//
//  UIImageView+Extra.m
//  Pashadelic
//
//  Created by Виталий Гоженко on 11/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIImageView+Extra.h"

@implementation UIImageView (Extra)

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
		
		self.image = loadedImage;
	}
}

- (void)sizeToFitWithImageSize:(CGSize)imageSize maxViewSize:(CGSize)maxSize
{
	CGSize size = [UIImageView sizeThatFitImageSize:imageSize maxViewSize:maxSize];
	
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
}


+ (CGSize)sizeThatFitImageSize:(CGSize)imageSize maxViewSize:(CGSize)maxSize
{
	if (imageSize.width <= maxSize.width && imageSize.height <= imageSize.height) return imageSize;
	double widthProportion = imageSize.width / maxSize.width;
	double heightProportion = imageSize.height / maxSize.height;
	double proportion;
	if (widthProportion <= heightProportion) {
		proportion = imageSize.height / maxSize.height;
	} else {
		proportion = imageSize.width / maxSize.width;
	}
	double width = round(imageSize.width / proportion);
	double height = round(imageSize.height / proportion);
	
	return CGSizeMake(width, height);
}

@end
