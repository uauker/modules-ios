//
//  Tweet.h
//  transitorio
//
//  Created by Uauker on 11/17/12.
//  Copyright (c) 2012 Uauker Inc. All rights reserved.
//

#import "TTUser.h"

@interface TTTweet : NSObject

@property (nonatomic, copy) NSString * identifier;
@property (nonatomic, retain) NSDate * publishedAt;
@property (nonatomic, copy) NSString * text;
@property (nonatomic, retain) NSNumber * retweetCount;

@property (nonatomic, retain) TTUser * user;

- (NSString *)toHourMinute;

@end
