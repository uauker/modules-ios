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
        [_instance setKeys];
    }
    
    return _instance;
}

- (STTwitterAPI *)api {
    return [STTwitterAPI twitterAPIWithOAuthConsumerName:self.consumerName consumerKey:self.consumerKey consumerSecret:self.consumerSecret oauthToken:self.accessToken oauthTokenSecret:self.accessTokenSecret];
}

- (void)setKeys {
    NSString *bundle = [[NSBundle mainBundle] bundleIdentifier];
    
    if ([bundle isEqualToString:@"com.uauker.apps.transitorio"]) {
        self.consumerName = @"Trânsito Rio";
        self.consumerKey = @"WPDngmoDgU7SgRinKG5A";
        self.consumerSecret = @"2fbdQ69bdHAkhRLsrLKjj9gvdtdxJsKB7jgosO45nE";
        self.accessToken = @"25685569-SSMXlJ5SQqQ56u1DuedEDyikdQG9Uxc6y6hWGJ7gg";
        self.accessTokenSecret = @"Vuc8NqLOwFXLVcKGphKKuh3XZnc8M5vEj61VQMEpWQ";
    } else if ([bundle isEqualToString:@"com.uauker.apps.transitosp"] || [bundle isEqualToString:@"com.uauker.apps.modules"]) {
        self.consumerName = @"Trânsito SP";
        self.consumerKey = @"jbk5awNzIK3CVN0QhGngBg";
        self.consumerSecret = @"EG4AWUZV7mhyANmnN2NKunYqxlrqAI9OAB5OqMbKEs";
        self.accessToken = @"25685569-fpeTkRMzjXfoawebbmYp7pWLNslnCjsYgWbSjUCxs";
        self.accessTokenSecret = @"ulGQZhFkNpxyfon3NtE03y4KRa5MH0Qj2Ti7tgMpxfI";
    }
}

@end
