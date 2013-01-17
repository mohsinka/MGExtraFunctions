//
//  UIButton+Extra.h
//  Pashadelic
//
//  Created by Виталий Гоженко on 11/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extra)

+ (UIButton *)buttonWithImage:(UIImage *)image;
+ (UIButton *)buttonWithTitle:(NSString *)title font:(UIFont *)font height:(int)height;
- (void)backgroundLoadImageWithParameters:(NSDictionary *)parameters;
- (void)loadImageWithParameters:(NSDictionary *)parameters;
- (void)setImage:(UIImage *)image forState:(UIControlState)state animated:(BOOL)animated;

@end
