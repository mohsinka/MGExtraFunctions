//
//  NSDate+Extra.m
//  Pet Calendar
//
//  Created by Vitaliy Gozhenko on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSDate+Extra.h"

@implementation NSDate (Extra)

- (NSDate *)dateByAddingTimeFromDate:(NSDate *)time {
	NSDateComponents *timeComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute fromDate:time];
	return [[NSCalendar currentCalendar] dateByAddingComponents:timeComponents toDate:self options:0];
}

+ (NSDate *)tomorrow {
	return [[[NSDate date] dateByAddingTimeInterval:kNSDateOneDayInterval] dayBegin];
}

- (NSString *)intervalInStringSinceDate:(NSDate *)date {
	if (!date) {
		date = [NSDate date];
	}
	int interval = round([date timeIntervalSinceDate:self]);
	interval = ABS(interval);
	
	if (interval < 0) {
		return @"";
	} else if (interval < kNSDateOneMinuteInterval) {
		return [NSString stringWithFormat:NSLocalizedString(@"just now", nil), interval];
	} else if (interval < kNSDateOneHourInterval) {
		return [NSString stringWithFormat:NSLocalizedString(@"%.0f minutes ago", nil), interval / kNSDateOneMinuteInterval];
	} else if (interval < kNSDateOneDayInterval) {
		return [NSString stringWithFormat:NSLocalizedString(@"%.0f hours ago", nil), interval / kNSDateOneHourInterval];
	} else if (interval < kNSDateOneWeekInterval) {
		return [NSString stringWithFormat:NSLocalizedString(@"%.0f days ago", nil), interval / kNSDateOneDayInterval];
	} else if (interval < kNSDateOneMonthInterval) {
		return [NSString stringWithFormat:NSLocalizedString(@"%.0f weeks ago", nil), interval / kNSDateOneWeekInterval];
	} else if (interval < kNSDateOneYearInterval) {
		return [NSString stringWithFormat:NSLocalizedString(@"%.0f month ago", nil), interval / kNSDateOneMonthInterval];
	} else {
		return [NSString stringWithFormat:NSLocalizedString(@"%.0f years ago", nil), interval / kNSDateOneYearInterval];
	} 
}

- (NSString *)shortIntervalInStringSinceDate:(NSDate *)date {
	if (!date) {
		date = [NSDate date];
	}

	CGFloat interval = round([date timeIntervalSinceDate:self]);
	interval = ABS(interval);
	
	if (interval < 0) {
		return @"";
	} else if (interval < kNSDateOneMinuteInterval) {
		return [NSString stringWithFormat:NSLocalizedString(@"now", nil), interval];
	} else if (interval < kNSDateOneHourInterval) {
		return [NSString stringWithFormat:NSLocalizedString(@"%.0fm", nil), interval / kNSDateOneMinuteInterval];
	} else if (interval < kNSDateOneDayInterval) {
		return [NSString stringWithFormat:NSLocalizedString(@"%.0fh", nil), interval / kNSDateOneHourInterval];
	} else if (interval < kNSDateOneWeekInterval) {
		return [NSString stringWithFormat:NSLocalizedString(@"%.0fd", nil), interval / kNSDateOneDayInterval];
	} else if (interval < kNSDateOneMonthInterval) {
		return [NSString stringWithFormat:NSLocalizedString(@"%.0fw", nil), interval / kNSDateOneWeekInterval];
	} else if (interval < kNSDateOneYearInterval) {
		return [NSString stringWithFormat:NSLocalizedString(@"%.0fm", nil), interval / kNSDateOneMonthInterval];
	} else {
		return [NSString stringWithFormat:NSLocalizedString(@"%.0fy", nil), interval / kNSDateOneYearInterval];
	}
}

- (NSString *)stringValueFormattedBy:(NSString *)formatString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setDateFormat:formatString];
    NSString *string = [dateFormatter stringFromDate:self];
    return string;
}

- (NSComparisonResult)compareMonth:(NSDate *)date {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *currentDateComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth 
														  fromDate:self];
	NSDateComponents *compareDateComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth 
														  fromDate:date];
	
	return [[calendar dateFromComponents:currentDateComponents] compare:
			[calendar dateFromComponents:compareDateComponents]];
}

- (NSComparisonResult)compareDay:(NSDate *)date {	
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *currentDateComponents = [calendar components:
											   NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
														  fromDate:self];
	NSDateComponents *compareDateComponents = [calendar components:
											   NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay 
														  fromDate:date];
	
	return [[calendar dateFromComponents:currentDateComponents] compare:
			[calendar dateFromComponents:compareDateComponents]];
}

- (NSDate *)dateByAddingMonth:(NSInteger)month {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
	dateComponents.month += month;
	return [calendar dateFromComponents:dateComponents];
}

- (NSDate *)monthBegin {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
	return [calendar dateFromComponents:dateComponents];
}

- (NSDate *)dayBegin {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
	return [calendar dateFromComponents:dateComponents];
}

- (NSDate *)monthEnd {
	return [[self dateByAddingMonth:1] dateByAddingTimeInterval:-1];
}

- (NSDate *)dayEnd {
	return [[self dayBegin] dateByAddingTimeInterval:kNSDateOneDayInterval - 1];
}

- (NSInteger)numberOfWeeksInMonth {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	
	NSDateComponents *componentsMonthBegin = [calendar components:NSCalendarUnitDay | NSCalendarUnitWeekday 
														 fromDate:self.monthBegin];
	
	NSUInteger numberOfDaysInMonth = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
	if (numberOfDaysInMonth == 30) {
		if (componentsMonthBegin.weekday == 7) {
			return 6;
		}
	} else if (numberOfDaysInMonth == 31) {
		if (componentsMonthBegin.weekday >= 6) {
			return 6;
		}
	}
	return 5;
}

- (BOOL)isEarlierThanDate:(NSDate *)date {
	return (self.timeIntervalSince1970 < date.timeIntervalSince1970);
}

- (BOOL)isLaterThanDate:(NSDate *)date {
	return (self.timeIntervalSince1970 > date.timeIntervalSince1970);
}

- (BOOL)isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate {
	if ([self compare:beginDate] == NSOrderedAscending)
		return NO;
	
	if ([self compare:endDate] == NSOrderedDescending)
		return NO;
	
	return YES;
}

- (NSInteger) daysBetweenDate:(NSDate *)date {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDate *fromDate;
	NSDate *toDate;
	[calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate interval:NULL forDate:self];
	[calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:date];
	NSDateComponents *difference = [calendar components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
	return ABS([difference day]);
}

@end
