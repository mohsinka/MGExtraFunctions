//
//  MGButtonImageLoaderOperation.h
//  Pashadelic
//
//  Created by Vitaliy Gozhenko on 19.12.12.
//
//

#import "MGImageLoaderOperation.h"

@interface MGButtonImageLoaderOperation : MGImageLoaderOperation
<MGImageLoaderOperationDelegate>

@property (weak, atomic) UIButton *button;

+ (id)operationWithURL:(NSString *)URL button:(UIButton *)button caching:(NSUInteger)caching;

@end
