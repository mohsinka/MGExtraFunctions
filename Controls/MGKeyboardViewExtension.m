//
//  MGKeyboardViewExtension.m
//  GotMyJobs
//
//  Created by Vitaliy Gozhenko on 08/04/15.
//  Copyright (c) 2015 Got My Jobs. All rights reserved.
//

#import "MGKeyboardViewExtension.h"

@interface MGKeyboardViewExtension ()

@property (weak, nonatomic) UIView *currentResponder;
@property (assign, nonatomic) CGRect keyboardFrame;
@property (assign, nonatomic) CGFloat previousOffset;
@property (strong, nonatomic) NSTimer *keyboardChangePauseTimer;
@property (weak, nonatomic) UIView *contentView;

@end

@implementation MGKeyboardViewExtension

- (instancetype)initWithRootViewController:(UIViewController *)viewController bottomView:(UIView *)bottomView; {
	if (self = [self init]) {
		_viewController = viewController;
		_contentView = viewController.view;
		_bottomView = bottomView;
	}
	return self;
}

- (instancetype)init
{
	if (self = [super init]) {
		_bottomPadding = 20;
	}
	return self;
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)startListeningKeyboardNotifications {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(responderDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(responderDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
}

- (void)stopListeningKeyboardNotifications {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWillShow:(NSNotification *)notification {
	if (self.viewController.isViewLoaded && self.viewController.view.window && self.contentView) {
		[self.keyboardChangePauseTimer invalidate];
		self.keyboardChangePauseTimer = nil;
		self.keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
		CGFloat animationDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
		[UIView animateWithDuration:animationDuration animations:^{
			[self offsetContentViewForCurrentKeyboardFrame];
		}];
	}
}

- (void)keyboardWillHide:(NSNotification *)notification {
	if (self.viewController.isViewLoaded && self.viewController.view.window && self.contentView) {
		CGFloat animationDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
		[UIView animateWithDuration:animationDuration animations:^{
			self.contentView.y = 0;
		} completion:^(BOOL finished) {
			self.previousOffset = 0;
		}];
	}
}

- (void)responderDidBeginEditing:(NSNotification *)notification {
	UIView *responder = notification.object;
	if (self.viewController.isViewLoaded
		&& self.viewController.view.window
		&& [responder isDescendantOfView:self.contentView]) {
		if (self.currentResponder && self.currentResponder != responder) {
			self.keyboardChangePauseTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(updateOffsetToNewResponder) userInfo:nil repeats:NO];
		}
		self.currentResponder = responder;
	} else {
		self.currentResponder = nil;
	}
}

- (void)updateOffsetToNewResponder {
	[UIView animateWithDuration:0.25 animations:^{
		[self offsetContentViewForCurrentKeyboardFrame];
	}];
}

- (void)offsetContentViewForCurrentKeyboardFrame {
	UIWindow *window = self.contentView.window;
	CGRect responderFrame = [window convertRect:self.currentResponder.bounds fromView:self.currentResponder];
	CGRect bottomViewFrame = [window convertRect:self.bottomView.bounds fromView:self.bottomView];
	CGFloat bottomY = MIN(MAX(responderFrame.origin.y + responderFrame.size.height, bottomViewFrame.origin.y + bottomViewFrame.size.height) + self.bottomPadding + self.previousOffset, window.bounds.size.height);
	CGFloat offset = bottomY - (window.bounds.size.height - self.keyboardFrame.size.height);
	if (offset > 0 || offset < -(window.bounds.size.height - self.keyboardFrame.size.height)) {
		self.previousOffset = self.contentView.y = -offset;
	}
}

@end
