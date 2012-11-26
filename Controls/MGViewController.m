//
//  MGViewController.m
//  Spaxtel
//
//  Created by Vitaliy Gozhenko on 18/10/12.
//
//

#import "MGViewController.h"
#import "UIView+Extra.h"

@interface MGViewController ()

@end

@implementation MGViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.yControlScrollOffset = 20;
	[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:self.view.window];
}

- (void)viewDidUnload
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (self.currentControl) {
		[self.currentControl resignFirstResponder];
	}
}

#pragma mark - Public

- (void)scrollToCurrentControl
{
	if (!self.contentScrollView || !self.currentControl) return;
	
	if (self.contentScrollView.height == self.contentScrollView.superview.height) return;
		
	int yOffset = _currentControl.y;
	UIView *superview = _currentControl.superview;
	while (superview != self.contentScrollView) {
		yOffset += superview.y;
		superview = superview.superview;
	}
	yOffset -= self.yControlScrollOffset;
	if (yOffset + self.contentScrollView.height > self.contentScrollView.contentSize.height) {
		yOffset = self.contentScrollView.contentSize.height - self.contentScrollView.height;
	}
	if (yOffset < 0) {
		yOffset = 0;
	}
	
	[self.contentScrollView setContentOffset:CGPointMake(0, yOffset) animated:YES];
}


- (void)keyboardWillShow:(NSNotification *)notification
{
	if (self.isKeyboardShown) return;
	self.keyboardShown = YES;
	
	if (!self.contentScrollView) return;
	
	CGRect frame = [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
	double duration = [[notification.userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
	
	[UIView animateWithDuration:duration animations:^{
		int height = self.contentScrollView.superview.height - frame.size.height;
		if (self.tabBarController.tabBar.y > 0) {
			height += self.tabBarController.tabBar.height;
		}
		self.contentScrollView.height = height;
		
	} completion:^(BOOL finished) {
		[self scrollToCurrentControl];
	}];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
	if (!self.isKeyboardShown || !self.contentScrollView) return;
	
	self.keyboardShown = NO;

	double duration = [[notification.userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
	
	[UIView animateWithDuration:duration animations:^{
		self.contentScrollView.height = self.contentScrollView.superview.height;
	}];
}


#pragma mark - Text field delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	self.currentControl = textField;
	[self scrollToCurrentControl];
	return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
	self.currentControl = textView;
	[self scrollToCurrentControl];
	return YES;
}



@end
