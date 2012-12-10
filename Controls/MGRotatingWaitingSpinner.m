//
//  PDForegroundWaitingSpinner.m
//  Pashadelic
//
//  Created by Виталий Гоженко on 22/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGRotatingWaitingSpinner.h"
#import "AdditionalFunctions.h"
#import <QuartzCore/QuartzCore.h>

#define kHeightCenterAutoresizeMask UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin

#define kWidthCenterAutoresizeMask UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin

#define kFullAutoresizeMask UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin

@implementation MGRotatingWaitingSpinner
@synthesize spinner = _spinner, foreground, timer, isShowing;

- (id)initWithStyle:(UIActivityIndicatorViewStyle)style
{
	self = [super initWithStyle:style];
	if (self) {
		self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
		self.autoresizingMask = kFullAutoresizeMask;
		foreground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
		foreground.layer.cornerRadius = 20;
		foreground.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
		[self addSubview:foreground];
		[foreground addSubview:self.spinner];
		isShowing = NO;
	}
	return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	
}

- (void)show
{
	self.hidden = NO;
	self.frame = CGRectMakeWithSize(0, 0, self.superview.frame.size);
	[self.spinner startAnimating];
	if (self.superview) {
		[self.superview bringSubviewToFront:self];
	}
	self.foreground.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
	self.spinner.center = CGPointMake(foreground.frame.size.width / 2, foreground.frame.size.height / 2);
	
	
	[self resetForeground];
	[self rotateForeground];
	timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(rotateForeground) userInfo:nil repeats:YES];
	isShowing = YES;
}

- (void)resetForeground
{
	foreground.transform = CGAffineTransformIdentity;
	angle = 0;
}

- (void)rotateForeground
{
	[UIView animateWithDuration:0.2 animations:^{
		angle += 90;
		foreground.transform = CGAffineTransformMakeRotation((M_PI * angle) / 180.0);
	}];	
}

- (void)hide
{
	[UIView animateWithDuration:0.15 animations:^{
		foreground.transform = CGAffineTransformMakeScale(0.01, 0.01);
		self.alpha = 0;
		
	} completion:^(BOOL finished) {
		isShowing = NO;
		[timer invalidate];
		self.hidden = YES;
		self.alpha = 1;
		foreground.transform = CGAffineTransformIdentity;
		[self.spinner stopAnimating];
		if (self.superview) {
			[self.superview sendSubviewToBack:self];
		}
	}];

}

@end
