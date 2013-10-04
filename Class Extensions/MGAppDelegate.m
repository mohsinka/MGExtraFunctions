//
//  MGAppDelegate.m
//  Order&Pay
//
//  Created by Виталий Гоженко on 27/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGAppDelegate.h"

@implementation MGAppDelegate
@synthesize waitingSpinnerView, internetActivitiesCount, documentsPath, cachePath, libraryPath;

- (void)hideWaitingSpinner
{
	if (waitingSpinnerView.isHidden) return;
	
	[waitingSpinnerView hide];
}

- (void)showWaitingSpinner
{
	if (!waitingSpinnerView.isHidden) return;
	[self.window addSubview:waitingSpinnerView];
	[waitingSpinnerView show];
}

- (void)initialize
{
	self.daysToStoreInCache = 5;
	waitingSpinnerView = [[MGRotatingWaitingSpinner alloc] initWithStyle:UIActivityIndicatorViewStyleWhiteLarge];
	[self.window addSubview:waitingSpinnerView];
	
	documentsPath = [[[[NSFileManager defaultManager]
					   URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]
					  lastObject] relativePath];
	
	cachePath = [[[[NSFileManager defaultManager]
				   URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask]
				  lastObject] relativePath];
	
	libraryPath = [[[[NSFileManager defaultManager]
					 URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask]
					lastObject] relativePath];
}

- (void)setInternetActivitiesCount:(int)newInternetActivitiesCount
{
	if ((newInternetActivitiesCount == 0 && internetActivitiesCount > 0) ||
		(internetActivitiesCount == 0 && newInternetActivitiesCount > 0)) {
		[UIApplication sharedApplication].networkActivityIndicatorVisible = (newInternetActivitiesCount > 0);
	}
	internetActivitiesCount = newInternetActivitiesCount;
}

- (void)clearOldCacheImagesInBackground
{
	[self performSelectorInBackground:@selector(clearOldCacheImages) withObject:nil];
}

- (void)clearOldCacheImages;
{
	@autoreleasepool {
		NSFileManager *manager = [NSFileManager defaultManager];
		NSArray *items = [manager contentsOfDirectoryAtPath:cachePath error:nil];
		
		for (NSString *file in items) {
			NSDictionary *attributes = [manager attributesOfItemAtPath:[cachePath stringByAppendingPathComponent:file]
																 error:nil];
			if (!attributes) continue;
			
			NSDate *fileDate = [attributes fileCreationDate];
			NSTimeInterval interval = fileDate.timeIntervalSinceNow;
			if (interval < - 60 * 60 * 24 * self.daysToStoreInCache) {
				[manager removeItemAtPath:file error:nil];
			}
		}
	}
}

@end
