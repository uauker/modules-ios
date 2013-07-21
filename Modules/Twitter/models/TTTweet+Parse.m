//
//  TTTweet+Parse.m
//  Projeto Modules
//
//  Created by Uauker on 6/14/13.
//  Copyright (c) 2013 Uauker Inc. All rights reserved.
//

#import "TTTweet+Parse.h"

@implementation TTTweet (Parse)

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (self) {
        self.identifier = [dictionary objectForKey:@"id_str"];
        self.publishedAt = [NSDate dateFromTweetString:[dictionary objectForKey:@"created_at"]];
        self.text = [dictionary objectForKey:@"text"];
        self.retweetCount = [NSNumber numberWithInt:[[dictionary objectForKey:@"retweet_count"] integerValue]];
        
        self.user = [[TTUser alloc] initWithDictionary:[dictionary objectForKey:@"user"]];
    }
    
    return self;
}

@end
