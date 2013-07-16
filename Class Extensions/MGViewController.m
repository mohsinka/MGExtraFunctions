//
//  MGViewController.m
//  Spaxtel
//
//  Created by Vitaliy Gozhenko on 18/10/12.
//
//

#import "MGViewController.h"
#import "UIView+Extra.h"
#import "AdditionalFunctions.h"

@interface MGViewController ()
@property (weak, nonatomic) id contentScrollViewDelegate;
@end

@implementation MGViewController

- (id)initFromClassName
{
	self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
	return self;
}

- (id)initForUniversalDevice
{
	NSString *nibName = [[self class] nibName];
	if (![[NSBundle mainBundle] pathForResource:nibName ofType:@"nib"]) {
		if (isPhone()) {
			nibName = [nibName stringByAppendingString:@"_iPhone"];
		} else {
			nibName = [nibName stringByAppendingString:@"_iPad"];
		}
	}
	self = [self initWithNibName:nibName bundle:nil];
	return self;
}

+ (NSString *)nibName
{
	return NSStringFromClass([self class]);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.yControlScrollOffset = 20;
	self.contentScrollViewDelegate = self.contentScrollView.delegate;
	self.contentScrollView.delegate = self;
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
	[super touchesBegan:touches withEvent:event];
	
	if (self.currentControl && self.hideKeyboardWhenTouch) {
		[self.currentControl resignFirstResponder];
	}
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
	if ([self.contentScrollViewDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
		[self.contentScrollViewDelegate performSelector:@selector(scrollViewWillBeginDragging:) withObject:scrollView];
	}
	if (!self.hideKeyboardWhenScroll || !self.isKeyboardShown) return;
	
	if (self.currentControl) {
		[self.currentControl resignFirstResponder];
	}
}

#pragma mark - Public

- (void)scrollToCurrentControl
{
	if (!self.contentScrollView
		|| !self.currentControl
		|| ![self.currentControl.superview isEqual:self.contentScrollView]) return;
	
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
	if (self.isKeyboardShown || !self.view.window) return;
	self.keyboardShown = YES;
	
	if (!self.contentScrollView) return;
	
	CGRect frame = [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
	double duration = [[notification.userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
	
	[UIView animateWithDuration:duration animations:^{
		int height = self.contentScrollView.superview.height - frame.size.height;
		if (self.tabBarController) {
			height += self.tabBarController.tabBar.height;
		}
		self.contentScrollView.height = height;
		
	} completion:^(BOOL finished) {
		[self scrollToCurrentControl];
	}];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
	if (!self.isKeyboardShown || !self.contentScrollView || !self.view.window) return;
	
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
	if (self.isKeyboardShown) {
		[self scrollToCurrentControl];
	}
	return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
	self.currentControl = textView;
	if (self.isKeyboardShown) {
		[self scrollToCurrentControl];
	}
	return YES;
}



@end
