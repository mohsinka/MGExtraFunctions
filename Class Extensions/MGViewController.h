//
//  MGViewController.h
//  Spaxtel
//
//  Created by Vitaliy Gozhenko on 18/10/12.
//
//

#import <UIKit/UIKit.h>

@interface MGViewController : UIViewController
<UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, getter = isKeyboardShown) BOOL keyboardShown;
@property (nonatomic) int yControlScrollOffset;
@property (assign, nonatomic) BOOL hideKeyboardWhenScroll;
@property (assign, nonatomic) BOOL hideKeyboardWhenTouch;
@property (unsafe_unretained, nonatomic) UIView *currentControl;
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *contentScrollView;

- (void)hideKeyboard;
- (id)initForUniversalDevice;
- (id)initFromClassName;
+ (NSString *)nibName;
- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardWillHide:(NSNotification *)notification;
- (void)scrollToCurrentControl;


@end
