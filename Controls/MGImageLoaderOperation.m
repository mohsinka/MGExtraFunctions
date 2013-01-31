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
	if (!self.delegate) return;
	if (![self.delegate respondsToSelector:@selector(imageDidFinishLoad:forObject:)]) return;
	
	[self.delegate performSelectorOnMainThread:@selector(imageDidFinishLoad:forObject:)
								withObject:image
								withObject:self.object
							 waitUntilDone:YES];
	self.delegate = nil;
}

- (void)failImageLoad:(NSString *)reason
{
	if (!self.delegate) return;
	if (![self.delegate respondsToSelector:@selector(imageDidFailLoadForObject:error:)]) return;
	
	[self.delegate performSelectorOnMainThread:@selector(imageDidFailLoadForObject:error:)
								withObject:self.object
								withObject:reason
							 waitUntilDone:YES];
	self.delegate = nil;
}

- (void)cancel
{
	self.delegate = nil;
	[super cancel];
}

- (void)dealloc
{
	self.delegate = nil;
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
	@try {

	@autoreleasepool {
		if (_URL.length == 0) {
			[self failImageLoad:NSLocalizedString(@"Can't load image: URL is empty", nil)];
			return;
		}
		
		MGImageLoader *loader = [MGImageLoader sharedInstance];
		
		NSString *imagePath = [[loader.cachePath stringByAppendingPathComponent:_hash] stringByAppendingPathExtension:MGImageLoaderFileExtension];
		
		UIImage *image = [loader cachedImageForKey:_hash];
		
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
				&& _hash) {
				[loader addImageToMemmoryCache:image hash:_hash];
			}
			
			[self finishImageLoad:image];
		} else {
			[self failImageLoad:[NSString stringWithFormat:
								 NSLocalizedString(@"Can't load image:\nIncorrect URL ""%@""", nil), _URL]];
		}
	}
	}
	@catch (NSException *exception) {
		NSLog(@"Exception %@ in %@ main block: delegate: %@, URL: %@", exception.description, NSStringFromClass([self class]), self.delegate, self.URL);
	}
	@finally {
	}
}

@end
