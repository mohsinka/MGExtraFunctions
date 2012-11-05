//
//  UIImageView+Extra.h
//  Pashadelic
//
//  Created by Виталий Гоженко on 11/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Extra)

- (void)backgroundLoadImageWithParameters:(NSDictionary *)parameters;
- (void)loadImageWithParameters:(NSDictionary *)parameters;
- (void)sizeToFitWithImageSize:(CGSize)imageSize maxViewSize:(CGSize)maxSize;
+ (CGSize)sizeThatFitImageSize:(CGSize)imageSize maxViewSize:(CGSize)maxSize;
@end
