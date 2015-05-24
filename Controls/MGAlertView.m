//
//  MGAlertView.m
//  Cover Canvas
//
//  Created by Vitaliy Gozhenko on 11/17/14.
//  Copyright (c) 2014 Logiexcel. All rights reserved.
//

#import "MGAlertView.h"

@interface MGAlertView ()

@property (strong, nonatomic) MGAlertViewCompletionHandler completionHandler;

@end

@implementation MGAlertView

- (void)showWithCompletionHandler:(void (^)(MGAlertView *, NSUInteger))completionHandler {
	self.completionHandler = completionHandler;
	self.delegate = self;
	[self show];
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
	if (self.completionHandler) {
		self.completionHandler(self, buttonIndex);
	}
}

- (void)alertViewCancel:(UIAlertView *)alertView {
	if (self.completionHandler) {
		self.completionHandler(self, self.cancelButtonIndex);
	}
}

@end
