// 
//  AdditionalFunctions.h
//
//  Created by Vitaliy Gozhenko on 10/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define UIColorFromRGB(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define IS_PAD ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
#define IS_PHONE ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone)

extern CGRect CGRectWithY(CGRect rect, CGFloat y);
extern CGRect CGRectWithX(CGRect rect, CGFloat x);
extern CGRect CGRectWithWidth(CGRect rect, CGFloat width);
extern CGRect CGRectWithHeight(CGRect rect, CGFloat height);
extern CGRect CGRectMakeWithSize(CGFloat x, CGFloat y, CGSize size);

@interface UIAlertView (Extra)
+ (void) showAlertWithTitle:(NSString *)title message:(NSString *)message;
@end

