//
//  MGAlertView.h
//  MarketBoard
//
//  Created by Vitaliy Gozhenko on 21.03.14.
//  Copyright (c) 2014 Statestudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGAlertView : NSObject

+ (instancetype)instance;
- (void)showError:(NSString *)error;

@end
