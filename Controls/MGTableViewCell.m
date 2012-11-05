//
//  MGTableViewCell.m
//  Pashadelic
//
//  Created by Vitaliy Gozhenko on 6/10/12.
//
//

#import "MGTableViewCell.h"

@implementation MGTableViewCell

- (NSString *)reuseIdentifier
{
	return NSStringFromClass([self class]);
}

@end
