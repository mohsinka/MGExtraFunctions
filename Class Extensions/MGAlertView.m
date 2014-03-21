//
//  MGAlertView.m
//  MarketBoard
//
//  Created by Vitaliy Gozhenko on 21.03.14.
//  Copyright (c) 2014 Statestudio. All rights reserved.
//

#import "MGAlertView.h"

@interface MGAlertView ()
<UIAlertViewDelegate>

@property (strong, nonatomic) UIAlertView *currentAlertView;

@end

@implementation MGAlertView

+ (instancetype)instance
{
  static dispatch_once_t once;
  static id instance;
  dispatch_once(&once, ^{
    instance = [[self alloc] init];
  });
  return instance;
}

- (void)showError:(NSString *)error
{
	if (error.length == 0) return;
	if ([error isEqualToString:self.currentAlertView.message]) return;
	
	NSString *message;
	if (self.currentAlertView.message.length > 0) {
		message = [NSString stringWithFormat:@"%@\n%@", self.currentAlertView.message, error];
	} else {
		message = error;
	}
	
	self.currentAlertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
	[self.currentAlertView show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	self.currentAlertView = nil;
}


@end
