//
//  AdditionalFunctions.m
//
//  Created by Vitaliy Gozhenko on 10/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AdditionalFunctions.h"

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
int RoundToInt(double x)
{
	return (int) round(x);
}

NSString * IntToString(NSInteger i)
{
	return [NSString stringWithFormat:@"%ld", (long)i];
}

NSString * FloatToString(float f)
{
	return [NSString stringWithFormat:@"%f", f];
}


NSString * BoolToString(BOOL value)
{
	if (value) {
		return NSLocalizedString(@"true", nil);
	} else {
		return NSLocalizedString(@"false", nil);
	}
}

@implementation UIAlertView (Extras)

+ (void) showAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:title 
                                                   message:message
                                                  delegate:nil
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
    [view show];
}

@end
