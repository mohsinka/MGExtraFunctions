//
//  UIButton+Extra.m
//  Pashadelic
//
//  Created by Виталий Гоженко on 11/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIButton+Extra.h"

@implementation UIButton (Extra)

+ (UIButton *)buttonWithImage:(UIImage *)image
{
	UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
	[button setImage:image forState:UIControlStateNormal];
	return button;
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state animated:(BOOL)animated
{
	if ([image isEqual:[self imageForState:state]]) return;
	
	if (animated) {
		self.alpha = 0;
		[self setImage:image forState:state];
		[UIView animateWithDuration:0.5 animations:^{
			self.alpha = 1;
		}];
	} else {
		[self setImage:image forState:state];
	}
}

- (void)backgroundLoadImageWithParameters:(NSDictionary *)parameters
{
	[self performSelectorInBackground:@selector(loadImageWithParameters:) withObject:parameters];
}

- (void)loadImageWithParameters:(NSDictionary *)parameters
{
	@autoreleasepool {	
		NSString *URL = [parameters valueForKey:@"URL"];
		NSNumber *identifier = [parameters valueForKey:@"identifier"];
		if (!identifier || !URL) return;
		
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
		NSString *imagePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"images_cache"];
		imagePath = [imagePath stringByAppendingPathComponent:URL.lastPathComponent];
		imagePath = [imagePath stringByAppendingString:identifier.stringValue];
		UIImage *loadedImage = [UIImage imageWithContentsOfFile:imagePath];
		
		if (!loadedImage) {
			NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:URL]];
			[data writeToFile:imagePath atomically:NO];
			loadedImage = [UIImage imageWithData:data];
		}
		
		[self setImage:loadedImage forState:UIControlStateNormal];
		[self setImage:loadedImage forState:UIControlStateHighlighted];
	}
}

@end
