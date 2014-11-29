//
//  MGMailComposeViewController.h
//  NewPracticeProgram
//
//  Created by Vitaliy Gozhenko on 11/25/14.
//  Copyright (c) 2014 Vitaliy Gozhenko. All rights reserved.
//

#import <MessageUI/MessageUI.h>

@class MGMailComposeViewController;
typedef void (^MGMailComposeViewControllerCompletionHandler)(MGMailComposeViewController *mailVC, NSError *error);


@interface MGMailComposeViewController : MFMailComposeViewController

- (void)showInViewController:(UIViewController *)viewController withCompletionHanlder:(MGMailComposeViewControllerCompletionHandler)completionHanlder;

@end
