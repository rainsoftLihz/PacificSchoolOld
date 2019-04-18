//
//  LSDateTool.m
//  WiClass
//
//  Created by Jonny on 2019/1/21.
//  Copyright © 2019 com.wistron. All rights reserved.
//

#import "LSDateTool.h"

@implementation LSDateTool

+ (NSString *)convertWeekday:(NSInteger)day {
    
    if (day == 1) {
        return @"一";
    }else if (day == 2){
        return @"二";
    }else if (day == 3){
        return @"三";
    }else if (day == 4){
        return @"四";
    }else if (day == 5){
        return @"五";
    }else if (day == 6){
        return @"六";
    }
    return @"";
}

#pragma mark - 获取当前时间-分
+ (NSString *)getCurrentDate {
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"HH:mm";
    NSString *currentDateString = [formatter stringFromDate:date];
    return currentDateString;
    NSLog(@"currentDateString %@",currentDateString);
    
}

+ (NSString *)getCurrentDate_day {
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *currentDateString = [formatter stringFromDate:date];
    return currentDateString;
    
}

#pragma mark - 获取当前时间-天
+ (NSString *)getCurrentDay {
    
    NSDate *date = [NSDate date];
    NSDateComponents *dateComonents = [[NSDateComponents alloc]init];
    NSInteger unitFlages = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    dateComonents = [calendar components:unitFlages fromDate:date];
    NSInteger weekday = dateComonents.weekday - 1;
    NSString *weekdayString = weekday == 0 ? @"日" : [NSString stringWithFormat:@"%@",[self convertWeekday:weekday]];
    
    NSString *currentDayString = [NSString stringWithFormat:@"%ld月%ld日 星期%@",dateComonents.month,dateComonents.day,weekdayString];
    return currentDayString;
    
}

+ (NSString *)stringDateValue {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self timeStampValue]];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
    
}

+ (NSString *)get_currentStringDateValue {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [NSDate date];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
    
}

+ (NSString *)getUTCStrFormateLocalStr:(NSString *)localStr {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *dateFormatted = [format dateFromString:localStr];
    format.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    NSString *dateString = [format stringFromDate:dateFormatted];
    return dateString;
}


+ (NSString *)stringDateMM:(NSString *)dateString {
    return [self mm_dateConvrrtTimestamp:[self mm_timestampConvrrtString:dateString]];
}

+ (NSString *)stringDateHHMM:(NSString *)dateString {
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc]init];
    [outputFormatter setDateFormat:@"HH:mm"];
    
    NSString *timeChanged = [outputFormatter stringFromDate:date];
    
    if (timeChanged == nil) {
        return dateString;
    }
    return  timeChanged;
}


+ (NSInteger)timeStampValue {
    NSDate *date = [NSDate date];
    NSInteger timeStamp = [date timeIntervalSince1970];
    return timeStamp;
}

+ (NSInteger)timeStampValue2 {
    NSDate *date = [NSDate date];
    NSInteger timeStamp = [date timeIntervalSince1970] *1000;
    return timeStamp;
}

+ (NSString *)beforeDate:(NSInteger)month {
    
    NSDate * mydate = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:mydate];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:-month];
    [adcomps setDay:0];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
    NSString *beforDate = [dateFormatter stringFromDate:newdate];
    //NSLog(@"---前4个月 =%@",beforDate);
    return beforDate;
}

+ (NSInteger )timestampConvrrtString:(NSString *)dateString {
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [dateFormatter dateFromString:dateString];
    NSInteger timestamp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    
    return timestamp;
}

+ (NSString *)dateConvrrtTimestamp:(NSInteger)timestamp {
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    return dateString;
}

+ (NSString *)ymdhm_dateConvrrtTimestamp:(NSInteger)timestamp {
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp/1000];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    return dateString;
}

+ (NSInteger )mm_timestampConvrrtString:(NSString *)dateString {
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [dateFormatter dateFromString:dateString];
    NSInteger timestamp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    
    return timestamp;
}

+ (NSString *)mm_dateConvrrtTimestamp:(NSInteger)timestamp {
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    return dateString;
}

+ (NSInteger )hhmm_timestampConvrrtString:(NSString *)dateString {
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    
    NSDate *date = [dateFormatter dateFromString:dateString];
    [dateFormatter stringFromDate:date];

    NSInteger timestamp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    
    return timestamp;
}

+ (NSString *)hhmm_dateConvrrtTimestamp:(NSInteger)timestamp {
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    return dateString;
}

+ (NSInteger)getWeekday:(NSString *)dateString {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self mm_timestampConvrrtString:dateString]];
    NSDateComponents *dateComonents = [[NSDateComponents alloc]init];
    NSInteger unitFlages = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    dateComonents = [calendar components:unitFlages fromDate:date];
    NSInteger weekday = dateComonents.weekday - 1;
    
    return weekday;
}


+(NSString *)inputTimeStr:(NSString *)timeStr withFormat:(NSString *)format

{
    
    NSDate *nowDate = [NSDate date];
    
    NSDate *sinceDate = [self becomeDateStr:timeStr withFormat:format];
    
    int i  = [nowDate timeIntervalSinceDate:sinceDate];
    
    
    
    NSString  *str  = @"";
    
    
    
    if (i <= 60)
        
    {//小于60s
        
        str = @"刚刚";
        
    }else if(i>60 && i<=3600)
        
    {//大于60s，小于一小时
        
        str = [NSString stringWithFormat:@"%d分钟前",i/60];
        
    }else if (i>3600 && i<60*60*24)
        
    {//
        
        if ([self isYesterdayWithDate:sinceDate])
            
        {//24小时内可能是昨天
            
            str = [NSString stringWithFormat:@"昨天"];
            
        }else
            
        {//今天
            
            str = [NSString stringWithFormat:@"%d小时前",i/3600];
            
        }
        
    }else
        
    {//
        
        int k = i/(3600*24);
        
        if ([self isYesterdayWithDate:sinceDate])
            
        {//大于24小时也可能是昨天
            
            str = [NSString stringWithFormat:@"昨天"];
            
        }else
            
        {
            
            //在这里大于1天的我们可以以周几的形式显示
            
            if (k>=1)
                
            {
                
                if (k < [self getNowDateWeek])
                    
                {//本周
                    
                    str  = [self weekdayStringFromDate:[self becomeDateStr:timeStr withFormat:format]];
                    
                }else
                    
                {//不是本周
                    
                    //                    str  = [NSString stringWithFormat:@"不是本周%@",[self weekdayStringFromDate:[self becomeDateStr:timeStr]]];
                    
                    str  = timeStr;
                    
                }
                
            }else
                
            {//
                
                str = [NSString stringWithFormat:@"%d天前",i/(3600*24)];
                
            }
            
        }
        
    }
    
    return str;
    
}

//把时间字符串转换成NSDate

+ (NSDate *)becomeDateStr:(NSString *)dateStr withFormat:(NSString *)format

{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    if (format) {
        [dateFormatter setDateFormat:format];
    }else{
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    NSDate *date1 = [dateFormatter dateFromString:dateStr];
    
    return date1;
    
}

//把时间转换成星期

+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    
    
    //    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"zh-Hans"];
    
    
    
    [calendar setTimeZone: timeZone];
    
    
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

//判断是否为昨天

+ (BOOL)isYesterdayWithDate:(NSDate *)newDate {
    
    BOOL isYesterday = YES;
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    //
    
    NSDate *yearsterDay =  [[NSDate alloc] initWithTimeIntervalSinceNow:-secondsPerDay];
    
    /** 前天判断
     
     //    NSDate *qianToday =  [[NSDate alloc] initWithTimeIntervalSinceNow:-2*secondsPerDay];
     
     //    NSDateComponents* comp3 = [calendar components:unitFlags fromDate:qianToday];
     
     //    if (comp1.year == comp3.year && comp1.month == comp3.month && comp1.day == comp3.day)
     
     //    {
     
     //        dateContent = @"前天";
     
     //    }
     
     **/
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    
    //    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:newDate];
    
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:yearsterDay];
    if ( comp1.year == comp2.year && comp1.month == comp2.month && comp1.day == comp2.day){
        
        isYesterday = YES;
        
    }else
        
    {
        
        isYesterday = NO;
        
    }
    
    return isYesterday;
    
}

//判断今天是本周的第几天

+ (int)getNowDateWeek

{
    
    NSDate *nowDate = [NSDate date];
    
    NSString *nowWeekStr = [self weekdayStringFromDate:nowDate];
    
    int  factWeekDay = 0;
    
    
    
    if ([nowWeekStr isEqualToString:@"周日"])
        
    {
        
        factWeekDay = 7;
        
    }else if ([nowWeekStr isEqualToString:@"周一"])
        
    {
        
        factWeekDay = 1;
        
    }else if ([nowWeekStr isEqualToString:@"周二"])
        
    {
        
        factWeekDay = 2;
        
    }else if ([nowWeekStr isEqualToString:@"周三"])
        
    {
        
        factWeekDay = 3;
        
    }else if ([nowWeekStr isEqualToString:@"周四"])
        
    {
        
        factWeekDay = 4;
        
    }else if ([nowWeekStr isEqualToString:@"周五"])
        
    {
        
        factWeekDay = 5;
        
    }else if ([nowWeekStr isEqualToString:@"周六"])
        
    {
        
        factWeekDay = 6;
        
    }
    
    return  factWeekDay;
    
}

@end
