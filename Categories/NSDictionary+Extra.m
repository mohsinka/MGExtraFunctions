//
//  NSDictionary+Extra.m
//  Pashadelic
//
//  Created by Виталий Гоженко on 20/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSDictionary+Extra.h"

@implementation NSDictionary (Extra)

- (NSDate *)dateForKey:(NSString *)key format:(NSString *)format
{
	id value = [self objectForKey:key];
	if (!value) return nil;
	if (![value isKindOfClass:[NSString class]]) return nil;

	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.dateFormat = format;
	return [dateFormatter dateFromString:value];
}

- (id)notNullObjectForKey:(id)key
{
	id value = [self objectForKey:key];
	if (!value) return nil;
	if ([value isKindOfClass:[NSNull class]]) return nil;
	return value;
}

- (NSDate *)unixDateForKey:(NSString *)key
{
	NSTimeInterval interval = [self doubleForKey:key];
	return [NSDate dateWithTimeIntervalSince1970:interval];
}

- (NSString *)stringForKey:(NSString *)key
{
	id value = [self objectForKey:key];
	if (!value) return @"";
	if ([value isKindOfClass:[NSNull class]]) return @"";
	return value;
}

- (int)intForKey:(NSString *)key
{
	id value = [self objectForKey:key];
	if (!value) return 0;
	if ([value isKindOfClass:[NSNull class]]) return 0;
	return [value intValue];
}

- (BOOL)boolForKey:(NSString *)key
{
	id value = [self objectForKey:key];
	if (!value) return 0;
	
	if ([value isKindOfClass:[NSNull class]]) return 0;

	return [value boolValue];
}

- (double)doubleForKey:(NSString *)key
{
	id value = [self objectForKey:key];
	if (!value) return 0;
	
	if ([value isKindOfClass:[NSNull class]]) return 0;

	return [value doubleValue];
}

- (float)floatForKey:(NSString *)key
{
	id value = [self objectForKey:key];
	if (!value) return 0;
	if ([value isKindOfClass:[NSNull class]]) return 0;

	return [value floatValue];
}

- (NSNumber *)numberForKey:(NSString *)key
{
	id value = [self objectForKey:key];
	if (!value) return [NSNumber numberWithInt:0];
	if ([value isKindOfClass:[NSNull class]]) return [NSNumber numberWithInt:0];

	if ([value isKindOfClass:[NSNumber class]]) {
		return value;
	} else if ([value isKindOfClass:[NSString class]]) {
		return [NSNumber numberWithDouble:[value doubleValue]];
	} else {
		return nil;
	}
}



@end
