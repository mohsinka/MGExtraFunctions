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
	self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
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
	NSArray *nib = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
	if (!nib) return nil;
	return [nib objectAtIndex:0];
}

- (void)showActivityWithStyle:(UIActivityIndicatorViewStyle)style
{
	self.userInteractionEnabled = NO;
	UIActivityIndicatorView *activityView = (UIActivityIndicatorView *) [self viewWithTag:kActivityViewTag];
	if (!activityView) {
		activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
		activityView.tag = kActivityViewTag;
		[activityView startAnimating];
		[self addSubview:activityView];
	}
	activityView.center = self.centerOfView;
}

- (void)hideActivity
{
	self.userInteractionEnabled = YES;
	UIView *activityView = [self viewWithTag:kActivityViewTag];
	if (!activityView) return;
	[activityView removeFromSuperview];
}

@end
