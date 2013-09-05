//
//  NSString+PGString.m
//  transitorio
//
//  Created by Uauker on 11/16/12.
//  Copyright (c) 2012 Uauker Inc. All rights reserved.
//

#import "NSString+PGString.h"

@implementation NSString (PGString)

- (BOOL)containsString:(NSString*)substring {
    NSRange range = [self rangeOfString : substring];
    BOOL found = ( range.location != NSNotFound );
    return found;
}

+ (NSString *)trim:(NSString *)string {
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (NSString *)trimWithBreakLine:(NSString *)string {
    return [[string componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@" "];
}

+ (NSString *)removeWhiteSpaceDuplicated:(NSString *)string {
    NSCharacterSet *whitespaces = [NSCharacterSet whitespaceCharacterSet];
    NSPredicate *noEmptyStrings = [NSPredicate predicateWithFormat:@"SELF != ''"];
    
    NSArray *parts = [string componentsSeparatedByCharactersInSet:whitespaces];
    NSArray *filteredArray = [parts filteredArrayUsingPredicate:noEmptyStrings];
    return [filteredArray componentsJoinedByString:@" "];
}

@end
