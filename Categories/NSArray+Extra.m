//
//  NSArray+Extra.m
//  Vlasne
//
//  Created by Виталий Гоженко on 15/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSArray+Extra.h"

@implementation NSArray (Extra)

- (NSArray *)arrayOfKey:(NSString *)key
{
	NSMutableArray *array = [NSMutableArray array];
	for (NSObject *object in self) {
		if ([object valueForKey:key]) {
			[array addObject:[object valueForKey:key]];
		}
	}
	return array;
}

- (id)firstObject
{
	if (self.count > 0) {
		return [self objectAtIndex:0];
	}
	return nil;
}

@end
