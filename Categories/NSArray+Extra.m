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

- (id)objectAtIndexOrNil:(NSUInteger)index
{
	if (index < self.count) {
		return [self objectAtIndex:index];
	} else {
		return nil;
	}
}

- (id)firstObject
{
	if (self.count > 0) {
		return [self objectAtIndex:0];
	}
	return nil;
}

- (NSArray*)shuffledArray {
	
    NSMutableArray *temp = [[NSMutableArray alloc] initWithArray:self];
	[temp shuffle];
    return [NSArray arrayWithArray:temp];
}

@end


@implementation NSMutableArray (Extra)


- (void)shuffle
{
    for(NSUInteger i = [self count]; i > 1; i--) {
        NSUInteger j = arc4random_uniform(i);
        [self exchangeObjectAtIndex:i-1 withObjectAtIndex:j];
    }
}

@end

