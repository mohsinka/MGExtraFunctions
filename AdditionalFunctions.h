// 
//  AdditionalFunctions.h
//
//  Created by Vitaliy Gozhenko on 10/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#define IS_PAD										(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_PHONE									(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_PHONE_4_INCH								(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568.0)

void ShowErrorDescriptionInLog(NSError *error);

CGRect CGRectWithY(CGRect rect, CGFloat y);
CGRect CGRectWithX(CGRect rect, CGFloat x);
CGRect CGRectWithWidth(CGRect rect, CGFloat width);
CGRect CGRectWithHeight(CGRect rect, CGFloat height);
CGRect CGRectMakeWithSize(CGFloat x, CGFloat y, CGSize size);
NSString * IntToString(int i);
NSString * BoolToString(BOOL value);
double RandomDouble(double start, double end);
double DistanceBetweenCoordinates(double latitudeFrom, double longitudeFrom, double latitudeTo, double longitudeTo);

@interface UIAlertView (Extras)
+ (void) showAlertWithTitle:(NSString *)title message:(NSString *)message;
@end

@interface UIColor (Extras)
+ (UIColor *) colorWithInteger:(NSInteger) integer;
+ (UIColor *) colorWithIntRed:(int)red green:(int)green blue:(int)blue alpha:(int)alpha;
+ (UIColor *)colorFromHexString:(NSString *)hexString;
@end
