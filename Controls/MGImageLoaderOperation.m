//
//  MGImageLoaderOperation.m
//  Pashadelic
//
//  Created by Vitaliy Gozhenko on 18.12.12.
//
//

#import "MGImageLoaderOperation.h"
#import "NSObject+Extra.h"
#import "MGImageLoader.h"
#import <objc/runtime.h>

@interface MGImageLoaderOperation (Private)
@end


@implementation MGImageLoaderOperation

- (id)init
{
	self = [super init];
	if (self) {
	}
	return self;
}

- (void)finishImageLoad:(UIImage *)image
{
	if (!_delegate) return;
	if (![_delegate respondsToSelector:@selector(imageDidFinishLoad:forObject:)]) return;
	
	[_delegate performSelectorOnMainThread:@selector(imageDidFinishLoad:forObject:)
								withObject:image
								withObject:_object
							 waitUntilDone:YES];		
}

- (void)failImageLoad:(NSString *)reason
{
	if (!_delegate) return;
	if (![_delegate respondsToSelector:@selector(imageDidFailLoadForObject:error:)]) return;
	
	[_delegate performSelectorOnMainThread:@selector(imageDidFailLoadForObject:error:)
								withObject:_object
								withObject:reason
							 waitUntilDone:YES];
}

- (NSString *)generateHashFromURL:(NSString *)URL
{
	return [[MGImageLoader sharedInstance] generateHashFromURL:URL];
}

+ (id)operationWithURL:(NSString *)URL
				object:(id)object
			  delegate:(id<MGImageLoaderOperationDelegate>)delegate
			   caching:(NSUInteger)caching
{
	MGImageLoaderOperation *operation = [[MGImageLoaderOperation alloc] init];
	if (operation) {
		operation.URL = URL;
		operation.object = object;
		operation.delegate = delegate;
		operation.caching = caching;
		operation.hash = [operation generateHashFromURL:URL];
	}
	return operation;
}

- (void)main
{
	@autoreleasepool {
		if (_URL.length == 0) {
			[self failImageLoad:NSLocalizedString(@"Can't load image: URL is empty", nil)];
			return;
		}
		
		MGImageLoader *loader = [MGImageLoader sharedInstance];
		
		NSString *hash = [self generateHashFromURL:_URL];
		NSString *imagePath = [[loader.cachePath stringByAppendingPathComponent:hash] stringByAppendingPathExtension:MGImageLoaderFileExtension];
		
		UIImage *image = [loader cachedImageForKey:hash];
		
		if (image) {
			[self finishImageLoad:image];
			return;
		}
		
		NSData *data = [[NSData alloc] initWithContentsOfFile:imagePath];
		BOOL cachedToDisk = NO;
		
		if (!data) {
			data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:_URL]];
		} else {
			cachedToDisk = YES;
		}
		
		image = [[UIImage alloc] initWithData:data];
		
		if (image) {
			if ((_caching & MGImageLoaderCachingTypeDisk) == MGImageLoaderCachingTypeDisk
				&& imagePath
				&& !cachedToDisk) {
				[data writeToFile:imagePath atomically:NO];
			}
			
			if ((_caching & MGImageLoaderCachingTypeMemmory) == MGImageLoaderCachingTypeMemmory
				&& hash) {
				[loader addImageToMemmoryCache:image hash:hash];
			}
			
			[self finishImageLoad:image];
		} else {
			[self failImageLoad:[NSString stringWithFormat:
								 NSLocalizedString(@"Can't load image:\nIncorrect URL ""%@""", nil), _URL]];
		}
	}
}

@end
