//
//  Tweet.m
//  transitorio
//
//  Created by Uauker on 11/17/12.
//  Copyright (c) 2012 Uauker Inc. All rights reserved.
//

#import "TTTweet.h"

@implementation TTTweet

- (NSString *)toHourMinute {
    if (self.publishedAt) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"HH:mm"];
        
        return [dateFormat stringFromDate:self.publishedAt];
    }
    
    return nil;
}

@end
