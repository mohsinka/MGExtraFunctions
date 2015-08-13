//
//  MGKeyboardViewExtension.h
//  GotMyJobs
//
//  Created by Vitaliy Gozhenko on 08/04/15.
//  Copyright (c) 2015 Got My Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MGKeyboardViewExtension : NSObject

@property (weak, nonatomic) UIViewController *viewController;
@property (weak, nonatomic) UIView *bottomView;
@property (assign, nonatomic) CGFloat bottomPadding;

- (instancetype)initWithRootViewController:(UIViewController *)viewController bottomView:(UIView *)bottomView;
- (void)startListeningKeyboardNotifications;
- (void)stopListeningKeyboardNotifications;

@end
