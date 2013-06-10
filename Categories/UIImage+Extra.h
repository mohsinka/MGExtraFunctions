//
//  UIImage+Extra.h
//  Pet Calendar
//
//  Created by Vitaliy Gozhenko on 2/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extra)

+ (UIImage *) stretchableImageWithName:(NSString *)name;
+ (UIImage *) buttonImageWithName:(NSString *)name;
+ (UIImage *) stretchableImageWithName:(NSString *)name edgeInset:(int)inset;
- (UIImage *) overlayWithImage:(UIImage *)image;
- (UIImage *) cutImageWithRect:(CGRect)rect;
- (UIImage *) fixOrientation;
- (UIImage *) imageWithColor:(UIColor *)color;

@end
