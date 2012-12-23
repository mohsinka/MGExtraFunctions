//
//  MGImageLoaderOperation.h
//  Pashadelic
//
//  Created by Vitaliy Gozhenko on 18.12.12.
//
//

#import <Foundation/Foundation.h>

@class MGImageLoaderOperation;
@protocol MGImageLoaderOperationDelegate <NSObject>
- (void)imageDidFinishLoad:(UIImage *)image forObject:(id)object;
- (void)imageDidFailLoadForObject:(id)object error:(NSString *)error;
@end

@interface MGImageLoaderOperation : NSOperation

@property (nonatomic) NSUInteger caching;
@property (strong, nonatomic) NSString *URL;
@property (unsafe_unretained, nonatomic) id object;
@property (unsafe_unretained, nonatomic) NSObject <MGImageLoaderOperationDelegate> *delegate;


+ (id)operationWithURL:(NSString *)URL
				object:(id)object
			  delegate:(id<MGImageLoaderOperationDelegate>)delegate
			   caching:(NSUInteger)caching;
- (NSString *)generateHashFromURL:(NSString *)URL;
- (void)finishImageLoad:(UIImage *)image;
- (void)failImageLoad:(NSString *)reason;

@end
