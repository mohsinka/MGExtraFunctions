//
//  PDForegroundWaitingSpinner.h
//  Pashadelic
//
//  Created by Виталий Гоженко on 22/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MGWaitingSpinnerView.h"

@interface MGRotatingWaitingSpinner : MGWaitingSpinnerView
{
	double angle;
}
@property (strong, nonatomic) UIView *foreground;
@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic) BOOL isShowing;

- (void)rotateForeground;
- (void)resetForeground;

@end

