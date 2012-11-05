//
//  NSString+Extra.m
//  Pet Calendar
//
//  Created by Vitaliy Gozhenko on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSString+Extra.h"

@implementation NSString (Extra)

+ (NSString *) stringWithDuration:(NSUInteger) duration
{
	int hours = duration / 3600;
	int minutes = (duration % 3600) / 60;
	int seconds = duration - hours * 3600 - minutes * 60;
	if (hours > 0) {
		return [NSString stringWithFormat:@"%d:%02d:%02d", hours, minutes, seconds];
	} else {
		return [NSString stringWithFormat:@"%d:%02d", minutes, seconds];
	}
}

- (NSString *)stringByRemovingCharacters:(NSString *)characters
{
	NSString *returnString = [self copy];
	for (int i = 0; i < characters.length; i++) {
		NSString *character = [characters substringWithRange:NSMakeRange(i, 1)];
		returnString = [returnString stringByReplacingOccurrencesOfString:character withString:@""];
	}
	
	return returnString;
}

- (NSString *) stringForSQLiteParameter 
{
	return [self stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
}

- (NSDate *) dateFormattedByString:(NSString *)formatString 
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatString];
    return [dateFormatter dateFromString:self];
}

- (BOOL)validateAsEmail
{
	NSString *expression = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSError *error = NULL;
	
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
	
    NSTextCheckingResult *match = [regex firstMatchInString:self options:0 range:NSMakeRange(0, [self length])];
	
    if (match) {
		return YES;
    }else{
		return NO;
    }

}
@end
