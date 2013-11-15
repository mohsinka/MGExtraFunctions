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
	MGImageLoaderCachingTypeMemory = 1 << 1,
	MGImageLoaderCachingTypeAll = MGImageLoaderCachingTypeDisk|MGImageLoaderCachingTypeMemory
	};

@interface MGImageLoader : NSObject
{	
	NSMutableDictionary *memoryCache;
	NSLock *lockCache;
	NSTimer *memoryWarningTimer;
	BOOL isMemoryWarningReceived;
}

@property (strong, nonatomic) 	NSString *cachePath;
@property (strong, nonatomic) 	NSFileManager *fileManager;
@property (strong, nonatomic)	NSOperationQueue *queue;
@property (assign, nonatomic)	NSUInteger maximumMemoryCacheItemsCount;


+ (MGImageLoader *)sharedInstance;

- (BOOL)isImageInCache:(NSString *)URL;
- (void)addOperation:(MGImageLoaderOperation *)operation;
- (NSString *)generateHashFromURL:(NSString *)URL;
- (UIImage *)cachedImageForKey:(NSString *)key;
- (UIImage *)loadImageFromCacheForURL:(NSString *)URL;
- (void)addImageToMemoryCache:(UIImage *)image hash:(NSString *)hash;
- (void)addImageToMemoryCache:(UIImage *)image URL:(NSString *)URL;
- (void)addImageToDiskCache:(UIImage *)image URL:(NSString *)URL;
- (void)memoryWarning;
- (void)clearMemoryCache;
- (void)clearDiskCache;
- (void)clearDiskCacheOlderThan:(NSUInteger)days;
- (void)clearCacheForImageURL:(NSString *)URL;
- (void)cancelOperationsWithDelegate:(NSObject <MGImageLoaderOperationDelegate> *)delegate;
- (void)cancelOperationsWithURL:(NSString *)URL;

@end
