//
//  MGImageLoader.m
//  Pashadelic
//
//  Created by Vitaliy Gozhenko on 18.12.12.
//
//

#import "MGImageLoader.h"
#import "MGImageViewLoaderOperation.h"
#import "MGButtonImageLoaderOperation.h"
#include <CommonCrypto/CommonDigest.h>

@interface MGImageLoader (Private)
- (void)initialize;
- (void)disableMemmoryWarningTimer;
@end


@implementation MGImageLoader


static MGImageLoader *_imageLoaderInstance;
+ (MGImageLoader *)sharedInstance
{
	@synchronized(self) {
		
        if (_imageLoaderInstance == nil) {
            _imageLoaderInstance = [[super alloc] init];
			[_imageLoaderInstance initialize];
        }
    }
    return _imageLoaderInstance;
}

#pragma mark - Private

- (void)initialize
{
	_queue = [[NSOperationQueue alloc] init];
	_queue.maxConcurrentOperationCount = 10;
	
	memmoryCache = [[NSMutableDictionary alloc] init];
	lock = [[NSLock alloc] init];
	
	_cachePath = [[[[NSFileManager defaultManager]
				   URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask]
				  lastObject] relativePath];
	
	_fileManager = [NSFileManager defaultManager];
}

- (void)disableMemmoryWarningTimer
{
	isMemmoryWarningReceived = NO;
	[memmoryWarningTimer invalidate];
	memmoryWarningTimer = nil;
}

#pragma mark - Public

- (void)memmoryWarning
{
	if (isMemmoryWarningReceived) return;
	
	isMemmoryWarningReceived = YES;
	[self clearMemmoryCache];
	memmoryWarningTimer = [NSTimer scheduledTimerWithTimeInterval:5
														   target:self
														 selector:@selector(disableMemmoryWarningTimer)
														 userInfo:nil
														  repeats:NO];
}

- (void)cancelOperationsWithDelegate:(NSObject<MGImageLoaderOperationDelegate> *)delegate
{
	for (MGImageLoaderOperation *operation in _queue.operations) {
		if (!operation.isExecuting && [operation.delegate isEqual:delegate]) {
			[operation cancel];
		}
	}
}

- (NSString *)generateHashFromURL:(NSString *)URL
{
	const char *cStr = [URL UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
	
    CC_MD5( cStr, strlen(cStr), result);
	return [NSString stringWithFormat: @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15] ];
}

- (UIImage *)cachedImageForKey:(NSString *)key
{
	return [memmoryCache objectForKey:key];
}

- (void)clearMemmoryCache
{
	[lock lock];
	[memmoryCache removeAllObjects];
	[lock unlock];
}

- (void)clearDiskCache
{
	[self clearDiskCacheOlderThan:0];
}

- (void)clearDiskCacheOlderThan:(NSUInteger)days
{
	@autoreleasepool {
		NSArray *items = [_fileManager contentsOfDirectoryAtPath:_cachePath error:nil];
		
		for (NSString *file in items) {
			if ([file rangeOfString:MGImageLoaderFileExtension].location
				!= file.length - MGImageLoaderFileExtension.length) return;
			
			NSDictionary *attributes = [_fileManager attributesOfItemAtPath:[_cachePath stringByAppendingPathComponent:file]
																	 error:nil];
			if (!attributes) continue;
			
			NSDate *fileDate = [attributes fileCreationDate];
			NSTimeInterval interval = fileDate.timeIntervalSinceNow;
			if (interval < - 60 * 60 * 24 * days) {
				[_fileManager removeItemAtPath:file error:nil];
			}
		}
	}
}

- (UIImage *)loadImageFromCacheForURL:(NSString *)URL
{	
	NSString *hash = [self generateHashFromURL:URL];
	NSString *imagePath = [[_cachePath stringByAppendingPathComponent:hash] stringByAppendingPathExtension:MGImageLoaderFileExtension];
	
	UIImage *image = [self cachedImageForKey:hash];
	
	if (image) {
		return image;
	}
	
	if ([_fileManager fileExistsAtPath:imagePath]) {
		image = [[UIImage alloc] initWithContentsOfFile:imagePath];
				
		if (image) {
			return image;
		}
	}
	return nil;
}

- (void)addImageToMemmoryCache:(UIImage *)image hash:(NSString *)hash
{
	[lock lock];
	[memmoryCache setValue:image forKey:hash];
	[lock unlock];
}

- (void)addImageToMemmoryCache:(UIImage *)image URL:(NSString *)URL
{
	if (!image || URL.length == 0) return;
	
	NSString *hash = [self generateHashFromURL:URL];
	[self addImageToMemmoryCache:image hash:hash];
}

- (void)addImageToDiskCache:(UIImage *)image URL:(NSString *)URL
{
	if (!image || URL.length == 0) return;
	
	NSString *hash = [self generateHashFromURL:URL];
	NSString *imagePath = [[_cachePath stringByAppendingPathComponent:hash] stringByAppendingPathExtension:MGImageLoaderFileExtension];
	NSData *data = UIImagePNGRepresentation(image);
	[data writeToFile:imagePath atomically:NO];
}

@end
