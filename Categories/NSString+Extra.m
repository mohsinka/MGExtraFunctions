//
//  NSString+Extra.m
//  Pet Calendar
//
//  Created by Vitaliy Gozhenko on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSString+Extra.h"

@implementation NSString (Extra)

- (NSString *)stringByRemovingCharacters:(NSString *)characters {
	NSString *returnString = [self copy];
	for (int i = 0; i < characters.length; i++) {
		NSString *character = [characters substringWithRange:NSMakeRange(i, 1)];
		returnString = [returnString stringByReplacingOccurrencesOfString:character withString:@""];
	}
	
	return returnString;
}

- (NSDate *) dateFormattedByString:(NSString *)formatString  {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setDateFormat:formatString];
    return [dateFormatter dateFromString:self];
}

- (BOOL)validateAsEmail {
	return [self validateWithRegEx:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
}

- (BOOL)validateWithRegEx:(NSString *)regExPattern {
	NSError *error;
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regExPattern options:0 error:&error];
	NSTextCheckingResult *match = [regex firstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
	if (error) {
		NSLog(@"Error validating with regex %@", regExPattern);
	}
	if (match) {
		NSRange range = [regex rangeOfFirstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
		if (range.length < self.length) {
			return NO;
		} else {
			return YES;
		}
	} else {
		return NO;
	}
}


@end
