//
//  MGMailComposeViewController.m
//  NewPracticeProgram
//
//  Created by Vitaliy Gozhenko on 11/25/14.
//  Copyright (c) 2014 Vitaliy Gozhenko. All rights reserved.
//

#import "MGMailComposeViewController.h"
#import "AdditionalFunctions.h"

@interface MGMailComposeViewController ()
<MFMailComposeViewControllerDelegate>

@property (copy, nonatomic) MGMailComposeViewControllerCompletionHandler completionHanlder;

@end

@implementation MGMailComposeViewController

- (void)showInViewController:(UIViewController *)viewController withCompletionHanlder:(MGMailComposeViewControllerCompletionHandler)completionHanlder
{
	if (![MFMailComposeViewController canSendMail]) {
		[UIAlertView showAlertWithTitle:nil message:NSLocalizedString(@"Can't send mail. Please setup your mail accounts", nil)];
		return;
	}
	self.completionHanlder = completionHanlder;
	self.mailComposeDelegate = self;
	[viewController presentViewController:self animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
	[self dismissViewControllerAnimated:YES completion:^{
		if (self.completionHanlder) {
			self.completionHanlder(self, error);
		}
	}];
}

@end
