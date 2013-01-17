//
//  MGGradientButton.h
//  Pashadelic
//
//  Created by Vitaliy Gozhenko on 17.01.13.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface MGGradientButton : UIButton

@property (strong, nonatomic) CAGradientLayer *gradientLayer;

- (void)setGradientFirstColor:(UIColor *)firstColor secondColor:(UIColor *)secondColor;

@end
