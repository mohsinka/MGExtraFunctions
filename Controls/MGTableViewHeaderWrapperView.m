//
//  MGTableViewHeaderWrapperView.m
//  GotMyJobs
//
//  Created by Vitaliy Gozhenko on 01/09/15.
//  Copyright (c) 2015 GotMyJobs. All rights reserved.
//

#import "MGTableViewHeaderWrapperView.h"

@implementation MGTableViewHeaderWrapperView

- (void)setCell:(UITableViewCell *)cell {
	if (_cell) {
		[_cell removeFromSuperview];
	}
	_cell = cell;
	cell.frame = self.bounds;
	cell.autoresizingMask = UIViewAutoresizingFlexibleWidthAndHeight;
	[self.contentView addSubview:cell];
}

@end
