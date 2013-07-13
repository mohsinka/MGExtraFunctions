//
//  MGLocalizedButton.m
//  Pashadelic
//
//  Created by Vitaliy Gozhenko on 13.07.13.
//
//

#import "MGLocalizedButton.h"

@implementation MGLocalizedButton

- (void)awakeFromNib
{
	[self setTitle:NSLocalizedString([self titleForState:UIControlStateNormal], nil) forState:UIControlStateNormal];
	[self setTitle:NSLocalizedString([self titleForState:UIControlStateHighlighted], nil) forState:UIControlStateHighlighted];
	[self setTitle:NSLocalizedString([self titleForState:UIControlStateDisabled], nil) forState:UIControlStateDisabled];
	[self setTitle:NSLocalizedString([self titleForState:UIControlStateSelected], nil) forState:UIControlStateSelected];
}

@end
