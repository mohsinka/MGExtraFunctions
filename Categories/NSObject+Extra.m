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

- (void)performSelectorOnMainThread:(SEL)aSelector withObject:(id)arg1 withObject:(id)arg2 waitUntilDone:(BOOL)wait
{
	if (aSelector == nil || arg1 == nil || arg2 == nil) return;
	
	NSMethodSignature *signature = [self methodSignatureForSelector:aSelector];
	NSInvocation *invoke = [NSInvocation invocationWithMethodSignature:signature];
	[invoke setTarget:self];
	[invoke setSelector:aSelector];
	[invoke setArgument:&arg1 atIndex:2];
	[invoke setArgument:&arg2 atIndex:3];
	[invoke retainArguments];
	[invoke performSelectorOnMainThread:@selector(invoke) withObject:nil waitUntilDone:wait];
}

@end
