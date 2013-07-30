//
//  MGImageViewLoaderOperation.m
//  Pashadelic
//
//  Created by Vitaliy Gozhenko on 19.12.12.
//
//

#import "MGImageViewLoaderOperation.h"

@implementation MGImageViewLoaderOperation

+ (id)operationWithURL:(NSString *)URL imageView:(UIImageView *)imageView caching:(NSUInteger)caching
{
	MGImageViewLoaderOperation *operation = [MGImageViewLoaderOperation new];
	if (operation) {
		operation.URL = URL;
		operation.imageView = imageView;
		operation.caching = caching;
		operation.delegate = operation;
		operation.hash = [operation generateHashFromURL:URL];
	}
	
	return operation;
}


#pragma mark - Image loader delegate

- (void)imageDidFinishLoad:(UIImage *)image forObject:(id)object
{
	if (!_imageView) return;
	
	if (![_imageView isKindOfClass:[UIImageView class]]) return;
	
	_imageView.image = image;
	
	self.imageView = nil;
}

- (void)imageDidFailLoadForObject:(id)object error:(NSString *)error
{
	NSLog(@"Fail to load image to %@:\n%@", _imageView, error);
	self.imageView = nil;
}

@end
