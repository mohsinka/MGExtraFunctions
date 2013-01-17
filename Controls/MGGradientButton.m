//
//  MGGradientButton.m
//  Pashadelic
//
//  Created by Vitaliy Gozhenko on 17.01.13.
//
//

#import "MGGradientButton.h"

@implementation MGGradientButton

- (void)awakeFromNib
{
	_gradientLayer = [CAGradientLayer layer];
	_gradientLayer.frame = self.frame;
	[self.layer addSublayer:_gradientLayer];
}

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		_gradientLayer = [CAGradientLayer layer];
		_gradientLayer.frame = frame;
		[self.layer addSublayer:_gradientLayer];
	}
	return self;
}

- (void)setFrame:(CGRect)frame
{
	[super setFrame:frame];
	_gradientLayer.frame = frame;
}

- (void)highlightView
{
    self.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.layer.shadowOpacity = 0.25;
}

- (void)clearHighlightView {
    self.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
    self.layer.shadowOpacity = 0.5;
}

- (void)setHighlighted:(BOOL)highlighted
{
    if (highlighted) {
        [self highlightView];
    } else {
        [self clearHighlightView];
    }
    [super setHighlighted:highlighted];
}

- (void)setGradientFirstColor:(UIColor *)firstColor secondColor:(UIColor *)secondColor
{
	_gradientLayer.colors = @[(id) firstColor.CGColor, (id) secondColor.CGColor];
	_gradientLayer.locations = @[@0.0, @1.0];
}

@end
