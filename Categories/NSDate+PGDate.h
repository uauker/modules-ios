//
//  NSDate+PGDate.h
//  transitorio
//
//  Created by Uauker on 11/15/12.
//  Copyright (c) 2012 Uauker Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (PGDate)

+ (NSDate *)dateFromTweetString:(NSString *)stringDate;
+ (NSDate *)convert:(NSString *)strDate withFormatter:(NSString *)strFormatter;

+ (NSString *)format:(NSDate *)date withFormatter:(NSString *)strFormatter;
+ (NSString *)format:(NSDate *)date withFormatter:(NSString *)strFormatter withTimeZone:(NSTimeZone *)timeZone;

@end
