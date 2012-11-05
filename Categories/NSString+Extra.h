//
//  NSString+Extra.h
//  Pet Calendar
//
//  Created by Vitaliy Gozhenko on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extra)
+ (NSString *) stringWithDuration:(NSUInteger) duration;
- (NSDate *) dateFormattedByString:(NSString *)formatString;
- (NSString *) stringForSQLiteParameter;
- (NSString *)stringByRemovingCharacters:(NSString *)characters;
- (BOOL)validateAsEmail;
@end
