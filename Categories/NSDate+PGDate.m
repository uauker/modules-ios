//
//  NSDate+PGDate.m
//  transitorio
//
//  Created by Uauker on 11/15/12.
//  Copyright (c) 2012 Uauker Inc. All rights reserved.
//

#import "NSDate+PGDate.h"

@implementation NSDate (PGDate)

static NSString *TWITTER_DATE_FORMAT = @"eee MMM dd HH:mm:ss Z yyyy";

+ (NSDate *)dateFromTweetString:(NSString *)stringDate {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setTimeZone:[NSTimeZone localTimeZone]];
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [df setDateFormat:TWITTER_DATE_FORMAT];
    return [df dateFromString:stringDate];
}

+ (NSDate *)convert:(NSString *)strDate withFormatter:(NSString *)strFormatter {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:strFormatter];
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en-US"];
    [format setLocale:locale];
    
    NSTimeZone *tz = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    [format setTimeZone:tz];
    
    return [format dateFromString:strDate];
}

+ (NSString *)format:(NSDate *)date withFormatter:(NSString *)strFormatter {
    return [NSDate format:date withFormatter:strFormatter withTimeZone:[NSTimeZone systemTimeZone]];
}

+ (NSString *)format:(NSDate *)date withFormatter:(NSString *)strFormatter withTimeZone:(NSTimeZone *)timeZone {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:strFormatter];

    NSLocale* formatterLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    [format setLocale:formatterLocale];
    
    [format setTimeZone:timeZone];
    
    return [format stringFromDate:date];
}

@end
