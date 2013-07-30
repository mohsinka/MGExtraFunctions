//
//  MGImageViewLoaderOperation.h
//  Pashadelic
//
//  Created by Vitaliy Gozhenko on 19.12.12.
//
//

#import "MGImageLoaderOperation.h"

@interface MGImageViewLoaderOperation : MGImageLoaderOperation
<MGImageLoaderOperationDelegate>

@property (strong, nonatomic) UIImageView *imageView;

+ (id)operationWithURL:(NSString *)URL imageView:(UIImageView *)imageView caching:(NSUInteger)caching;

@end
