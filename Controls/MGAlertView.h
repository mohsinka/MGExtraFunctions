//
//  MGAlertView.h
//  Cover Canvas
//
//  Created by Vitaliy Gozhenko on 11/17/14.
//  Copyright (c) 2014 Logiexcel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MGAlertView;
typedef void (^MGAlertViewCompletionHandler)(MGAlertView *alertView, NSUInteger selectedButton);


@interface MGAlertView : UIAlertView
<UIAlertViewDelegate>

- (void)showWithCompletionHandler:(MGAlertViewCompletionHandler)completionHandler;

@end
