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

- (UIViewController *)firstViewController {
	return [self traverseResponderChainToObjectClass:[UIViewController class]];
}

- (UINavigationController *)firstNavigationController {
	return [self traverseResponderChainToObjectClass:[UINavigationController class]];
}

- (id)traverseResponderChainToObjectClass:(Class)objectClass {
	id responder = [self nextResponder];
	if (responder) {
		if ([responder isKindOfClass:objectClass]) {
			return responder;
		} else if ([responder isKindOfClass:[UIView class]]) {
			return [responder traverseResponderChainToObjectClass:objectClass];
		} else if ([responder isKindOfClass:[UIViewController class]]) {
			return [[[responder view] superview] traverseResponderChainToObjectClass:objectClass];
		} else {
			return nil;
		}
	} else {
		return nil;
	}
}

- (id)traverseSuperviewToClass:(Class)superviewClass {
	UIView *superview = self.superview;
	while (superview && ![superview isKindOfClass:superviewClass]) {
		superview = superview.superview;
	}
	return superview;
}

- (void)rasterizeLayer {
	self.layer.shouldRasterize = YES;
	self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (void)setPosition:(CGPoint)position {
	self.frame = CGRectMakeWithSize(position.x, position.y, self.frame.size);
}

- (CGPoint)position {
	return self.frame.origin;
}

- (CGPoint)centerOfView {
	return CGPointMake(roundf(self.width / 2), roundf(self.height / 2));
}

- (CGFloat) width {
	return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
	self.frame = CGRectWithWidth(self.frame, width);
}

- (CGFloat) height {
	return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
	self.frame = CGRectWithHeight(self.frame, height);
}

- (CGFloat) x {
	return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
	self.frame = CGRectWithX(self.frame, x);
}

- (CGFloat) y {
	return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
	self.frame = CGRectWithY(self.frame, y);
}

- (CGFloat)bottomYPoint {
	return self.y + self.height;
}

- (CGRect)zeroPositionFrame {
	return CGRectMakeWithSize(0, 0, self.frame.size);
}

- (CGFloat)rightXPoint {
	return self.x + self.width;
}

+ (id)loadFromNibNamed:(NSString *)nibName {
	if (![[NSBundle mainBundle] pathForResource:nibName ofType:@"nib"]) {
		if (IS_PHONE) {
			nibName = [nibName stringByAppendingString:@"_iPhone"];
		} else {
			nibName = [nibName stringByAppendingString:@"_iPad"];
		}
	}
	NSArray *nib = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
	return [nib objectAtIndex:0];
}

- (void)showActivityWithStyle:(UIActivityIndicatorViewStyle)style color:(UIColor *)color {
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

- (void)showActivityWithStyle:(UIActivityIndicatorViewStyle)style {
	[self showActivityWithStyle:style color:nil];
}

- (void)setAllSubviewsHidden:(BOOL)hidden {
	for (UIView *view in self.subviews) {
    [view setHidden:hidden];
	}
}

- (void)hideActivity {
	self.userInteractionEnabled = YES;
	UIView *activityView = [self viewWithTagWithoutSubviews:kActivityViewTag];
	if (!activityView) return;
	[activityView removeFromSuperview];
}

- (BOOL)isActivityShown {
	if ([self viewWithTagWithoutSubviews:kActivityViewTag]) {
		return YES;
	} else {
		return NO;
	}
}

- (UIImage *)captureViewToUIImage {
	UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0);
	[self.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return viewImage;
}

- (UIView *)viewWithTagWithoutSubviews:(NSUInteger)tag {
	for (UIView *view in self.subviews) {
    if (view.tag == tag) return view;
	}
	
	return nil;
}

@end
