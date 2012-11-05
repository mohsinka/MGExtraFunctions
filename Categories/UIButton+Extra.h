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
- (void)backgroundLoadImageWithParameters:(NSDictionary *)parameters;
- (void)loadImageWithParameters:(NSDictionary *)parameters;

@end
