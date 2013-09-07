//
//  AdditionalFunctions.m
//
//  Created by Vitaliy Gozhenko on 10/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AdditionalFunctions.h"
#import <QuartzCore/QuartzCore.h>

void ShowErrorDescriptionInLog(NSError *error)
{
	if (error) {
		NSLog(@"%@", error.localizedDescription);
	}
}

CGRect CGRectWithY(CGRect rect, CGFloat y)
{
	CGRect newRect = rect;
	newRect.origin.y = y;
	return newRect;
}

CGRect CGRectWithX(CGRect rect, CGFloat x)
{
	CGRect newRect = rect;
	newRect.origin.x = x;
	return newRect;
}

CGRect CGRectWithWidth(CGRect rect, CGFloat width)
{
	CGRect newRect = rect;
	newRect.size.width = width;
	return newRect;
}

CGRect CGRectWithHeight(CGRect rect, CGFloat height)
{
	CGRect newRect = rect;
	newRect.size.height	= height;
	return newRect;
}

CGRect CGRectMakeWithSize(CGFloat x, CGFloat y, CGSize size)
{
	return CGRectMake(x, y, size.width, size.height);
}

NSString * IntToString(int i)
{
	return [NSString stringWithFormat:@"%d", i];
}

NSString * BoolToString(BOOL value)
{
	if (value) {
		return NSLocalizedString(@"enabled", nil);
	} else {
		return NSLocalizedString(@"disabled", nil);
	}
}

double RandomDouble(double start, double end)
{
    return (((double) rand() / RAND_MAX) * (end - start)) + start;
}

double DistanceBetweenCoordinates(double latitudeFrom, double longitudeFrom, double latitudeTo, double longitudeTo)
{
	latitudeFrom  = M_PI * latitudeFrom / 180;
	longitudeFrom  = M_PI * longitudeFrom / 180;
	latitudeTo  = M_PI * latitudeTo / 180;
	longitudeTo  = M_PI * longitudeTo / 180;
	
	double earthRadius = 3958.75;
	double dLat = latitudeTo - latitudeFrom;
	double dLon = longitudeTo - longitudeFrom;
	double a = sin(dLat/2) * sin(dLat/2) + cos(latitudeFrom) * cos(latitudeTo) * sin(dLon/2) * sin(dLon/2);
	double c = 2 * atan2(sqrt(a), sqrt(1-a));
	double distance = earthRadius * c;
	double meterConversion = 1609.00;
	return distance * meterConversion;
}


@implementation UIAlertView (Extras)

+ (void) showAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:title 
                                                   message:message
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
    [view show];
}

@end

@implementation NSString (Extras)
- (BOOL)validateAsEmail
{
	NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	
    return [emailTest evaluateWithObject:self];
}
@end

@implementation UIColor (Extras)

+ (UIColor *)colorWithInteger:(NSInteger)integer 
{
	CGFloat red = integer % 256;
	integer = integer / 256;
	CGFloat green = integer % 256;
	integer = integer / 256;
	CGFloat blue = integer % 256;
	return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

+ (UIColor *) colorWithIntRed:(int)red green:(int)green blue:(int)blue alpha:(int)alpha
{
	CGFloat floatRed = red / 255.0;
	CGFloat floatGreen = green / 255.0;
	CGFloat floatBlue = blue / 255.0;
	CGFloat floatAlpha = alpha / 255.0;
	return [UIColor colorWithRed:floatRed green:floatGreen blue:floatBlue alpha:floatAlpha];
}

+ (UIColor *)colorFromHexString:(NSString *)hexString {
	if (hexString.length == 0) return nil;
	NSUInteger red, green, blue, alpha = 1;
	if (hexString.length < 7) {
		sscanf([hexString UTF8String], "#%02X%02X%02X", &red, &green, &blue);
	} else {
		sscanf([hexString UTF8String], "#%02X%02X%02X%02X", &alpha, &red, &green, &blue);
	}
	
	return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha / 255.0];
}

- (UIColor *)grayscaleColor
{
	CGFloat red = 0;
    CGFloat blue = 0;
    CGFloat green = 0;
    CGFloat alpha = 0;
    if ([self getRed:&red green:&green blue:&blue alpha:&alpha]) {
        return [UIColor colorWithWhite:(0.299*red + 0.587*green + 0.114*blue) alpha:alpha];
    } else {
        return self;
    }
}

@end