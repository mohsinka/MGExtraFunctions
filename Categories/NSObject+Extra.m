//
//  NSObject+Extra.m
//  Vlasne
//
//  Created by Виталий Гоженко on 13/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSObject+Extra.h"

@implementation NSObject (Extra)

- (NSNumber *)numberValue
{
	if ([self isKindOfClass:[NSString class]]) {
		NSString *string = (NSString *) self;
		return [NSNumber numberWithDouble:[string doubleValue]];
	} else if ([self isKindOfClass:[NSNumber class]]) {
		return (NSNumber *) self;
	} else {
		return nil;
	}
}

+ (NSString *)className
{
	return NSStringFromClass([self class]);
}

@end
