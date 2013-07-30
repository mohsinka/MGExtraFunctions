//
//  MGButtonImageLoaderOperation.m
//  Pashadelic
//
//  Created by Vitaliy Gozhenko on 19.12.12.
//
//

#import "MGButtonImageLoaderOperation.h"

@implementation MGButtonImageLoaderOperation

+ (id)operationWithURL:(NSString *)URL button:(UIButton *)button caching:(NSUInteger)caching
{
	MGButtonImageLoaderOperation *operation = [MGButtonImageLoaderOperation new];
	if (operation) {
		operation.URL = URL;
		operation.button = button;
		operation.caching = caching;
		operation.delegate = operation;
		operation.hash = [operation generateHashFromURL:URL];
	}
	
	return operation;
}


#pragma mark - Image loader delegate

- (void)imageDidFinishLoad:(UIImage *)image forObject:(id)object
{
	if (!_button) return;
	
	if (![_button isKindOfClass:[UIButton class]]) return;
	
	[_button setImage:image forState:UIControlStateNormal];
	self.button = nil;
}

- (void)imageDidFailLoadForObject:(id)object error:(NSString *)error
{
	NSLog(@"Fail to load image to %@:\n%@", _button, error);
	self.button = nil;
}
@end
