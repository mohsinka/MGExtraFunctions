//
//  UILabel+Extra.m
//  Order&Pay
//
//  Created by Vitaliy Gozhenko on 2/10/12.
//
//

#import "UILabel+Extra.h"

@implementation UILabel (Extra)

- (void)resizeHeightWithCurrentText
{
	int height = [self.text sizeWithFont:self.font
					   constrainedToSize:CGSizeMake(self.frame.size.width, 9999)
						   lineBreakMode:self.lineBreakMode].height;
	CGRect rect = self.frame;
	rect.size.height = height;
	self.frame = rect;
}

@end
