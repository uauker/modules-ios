//
//  TwitterHelper.m
//  Projeto Modules
//
//  Created by Uauker on 9/2/13.
//  Copyright (c) 2013 Uauker Inc. All rights reserved.
//

#import "TwitterHelper.h"

@implementation TwitterHelper

static TwitterHelper* _instance;

+ (TwitterHelper *) sharedInstance {
    if (!_instance) {
        _instance = [[TwitterHelper alloc] init];
    }
    
    return _instance;
}

- (STTwitterAPI *)api {
    [self setKeys];
    
    return [STTwitterAPI twitterAPIWithOAuthConsumerName:K_TWITTER_CONSUMER_NAME consumerKey:K_TWITTER_CONSUMER_KEY consumerSecret:K_TWITTER_CONSUMER_SECRET oauthToken:K_TWITTER_ACCESS_TOKEN oauthTokenSecret:K_TWITTER_ACCESS_TOKEN_SECRET];
}

- (void)setKeys {
    NSString *bundle = [[NSBundle mainBundle] bundleIdentifier];
    
    if ([bundle isEqualToString:@"com.uauker.apps.transitorio"]) {
        
    }
}

@end
