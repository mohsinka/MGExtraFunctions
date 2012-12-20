//
//  MGImageLoader.h
//  Pashadelic
//
//  Created by Vitaliy Gozhenko on 18.12.12.
//
//

#import <Foundation/Foundation.h>
#import "MGImageLoaderOperation.h"
#import "MGImageViewLoaderOperation.h"
#import "MGButtonImageLoaderOperation.h"
#import "NSObject+Extra.h"

#define MGImageLoaderFileExtension @"ImageCache"

enum MGImageLoaderCachingType {
	MGImageLoaderCachingTypeNone = 0,
	MGImageLoaderCachingTypeDisk = 1 << 0,
	MGImageLoaderCachingTypeMemmory = 1 << 1,
	MGImageLoaderCachingTypeAll = MGImageLoaderCachingTypeDisk|MGImageLoaderCachingTypeMemmory
	};

@interface MGImageLoader : NSObject
{	
	NSMutableDictionary *memmoryCache;
	NSLock *lock;
}

@property (strong, nonatomic) 	NSString *cachePath;
@property (strong, nonatomic) 	NSFileManager *fileManager;
@property (strong, nonatomic)	NSOperationQueue *queue;


+ (MGImageLoader *)sharedInstance;

- (NSString *)generateHashFromURL:(NSString *)URL;
- (UIImage *)cachedImageForKey:(NSString *)key;
- (UIImage *)loadImageFromCacheForURL:(NSString *)URL;
- (void)addImageToMemmoryCache:(UIImage *)image hash:(NSString *)hash;
- (void)addImageToMemmoryCache:(UIImage *)image URL:(NSString *)URL;
- (void)addImageToDiskCache:(UIImage *)image URL:(NSString *)URL;
- (void)clearMemmoryCache;
- (void)clearDiskCache;
- (void)clearDiskCacheOlderThan:(NSUInteger)days;

@end
