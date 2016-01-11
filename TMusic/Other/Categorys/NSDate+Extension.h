//
//  NSDate+Extension.h
//  云图在线
//
//  Created by LuXulong on 15/11/14.
//  Copyright © 2015年 Hydaya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

- (NSString *) stringFromDate:(NSDate *)date;
- (NSDate *) dateFromString:(NSString *)dateString;
- (NSInteger) day:(NSDate *)date;
- (NSInteger) month:(NSDate *)date;
- (NSInteger) year:(NSDate *)date;
- (NSInteger) firstWeekdayInThisMonth:(NSDate *)date;
- (NSInteger) totaldaysInThisMonth:(NSDate *)date;
- (NSInteger) totaldaysInLastMonth:(NSDate *)date;
- (NSDate *) lastMonth:(NSDate *)date;
- (NSDate*) nextMonth:(NSDate *)date;

@end
