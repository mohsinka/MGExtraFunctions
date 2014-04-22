//
//  UIView+Extra.m
//  Pet Calendar
//
//  Created by Vitaliy Gozhenko on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIView+Extra.h"
#import "AdditionalFunctions.h"

@implementation UIView (Extra)

- (void)rasterizeLayer
{
	self.layer.shouldRasterize = YES;
	self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (CGPoint)centerOfView
{
	return CGPointMake(roundf(self.width / 2), roundf(self.height / 2));
}

- (CGFloat) width
{
	return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
	self.frame = CGRectWithWidth(self.frame, width);
}

- (CGFloat) height
{
	return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
	self.frame = CGRectWithHeight(self.frame, height);
}

- (CGFloat) x
{
	return self.frame.origin.x;
}

- (void)setX:(CGFloat)x
{
	self.frame = CGRectWithX(self.frame, x);
}

- (CGFloat) y
{
	return self.frame.origin.y;
}

- (void)setY:(CGFloat)y
{
	self.frame = CGRectWithY(self.frame, y);
}

- (CGFloat)bottomYPoint
{
	return self.y + self.height;
}

- (CGRect)zeroPositionFrame
{
	return CGRectMakeWithSize(0, 0, self.frame.size);
}

- (void)clearBackgroundColor
{
	self.backgroundColor = [UIColor clearColor];
}

- (CGFloat)rightXPoint
{
	return self.x + self.width;
}

- (void)setFullAutoresizingMask
{
	self.autoresizingMask = kFullAutoresizingMask;
}

- (void)setRating:(int)rating
{
	if (rating > kExtraMinRatingTag && rating <= kExtraMinRatingTag + 5) {
		rating -=kExtraMinRatingTag;
	}
	for (int i = kExtraMinRatingTag + 1; i <= kExtraMinRatingTag + 5; i++) {
		id star = [self viewWithTag:i];
		BOOL highlight = (i - kExtraMinRatingTag <= rating);
		if ([star isKindOfClass:[UIImageView class]]) {
			[star setHighlighted:highlight];
		} else if ([star isKindOfClass:[UIButton class]]) {
			[star setSelected:highlight];
		}
	}
}

- (int)rating
{
	int rating = 0;
	for (int i = kExtraMinRatingTag + 1; i <= kExtraMinRatingTag + 5; i++) {
		id star = [self viewWithTag:i];
		
		if ([star isKindOfClass:[UIImageView class]]) {
			if ([star isHighlighted]) {
				rating++;
			}
			
		} else if ([star isKindOfClass:[UIButton class]]) {
			if ([star isSelected]) {
				rating++;
			}

		}
	}
	return rating;
}

- (UIViewController *)firstViewController 
{
    return (UIViewController *) [self traverseResponderChainForUIViewController];
}

- (id) traverseResponderChainForUIViewController
{
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    } else if ([nextResponder isKindOfClass:[UIView class]]) {
        return [nextResponder traverseResponderChainForUIViewController];
    } else {
        return nil;
    }
}

+ (id)loadFromNibNamed:(NSString *)nibName
{
	if (![[NSBundle mainBundle] pathForResource:nibName ofType:@"nib"]) {
		if (isPhone()) {
			nibName = [nibName stringByAppendingString:@"_iPhone"];
		} else {
			nibName = [nibName stringByAppendingString:@"_iPad"];
		}
	}
	NSArray *nib = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
	return [nib objectAtIndex:0];
}

- (void)showActivityWithStyle:(UIActivityIndicatorViewStyle)style color:(UIColor *)color
{
	self.userInteractionEnabled = NO;
	UIActivityIndicatorView *activityView = (UIActivityIndicatorView *) [self viewWithTagWithoutSubviews:kActivityViewTag];
	if (!activityView) {
		activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
		activityView.tag = kActivityViewTag;
    activityView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin;
		[activityView startAnimating];
		[self addSubview:activityView];
	}
	if (color) {
		activityView.color = color;
	}
	activityView.center = self.centerOfView;
}

- (void)showActivityWithStyle:(UIActivityIndicatorViewStyle)style
{
	[self showActivityWithStyle:style color:nil];
}

- (void)hideActivity
{
	self.userInteractionEnabled = YES;
	UIView *activityView = [self viewWithTagWithoutSubviews:kActivityViewTag];
	if (!activityView) return;
	[activityView removeFromSuperview];
}

- (UIImage *)captureView
{
	UIGraphicsBeginImageContext(self.frame.size);
	[self.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return viewImage;
}

- (UIView *)viewWithTagWithoutSubviews:(NSUInteger)tag
{
	for (UIView *view in self.subviews) {
    if (view.tag == tag) return view;
	}
	
	return nil;
}

@end
