//
//  TTUser+Parse.m
//  Projeto Modules
//
//  Created by Uauker on 6/14/13.
//  Copyright (c) 2013 Uauker Inc. All rights reserved.
//

#import "TTUser+Parse.h"

@implementation TTUser (Parse)


- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (self) {
        self.identifier = [dictionary objectForKey:@"id_str"];
        self.createdAt = [NSDate dateFromTweetString:[dictionary objectForKey:@"created_at"]];
        self.name = [dictionary objectForKey:@"name"];
        self.profileBackgroundImageUrl = [dictionary objectForKey:@"profile_background_image_url"];
        self.profileImageUrl = [dictionary objectForKey:@"profile_image_url"];
        self.screenName = [dictionary objectForKey:@"screen_name"];
        self.text = [dictionary objectForKey:@"description"];
        self.url = ([[dictionary objectForKey:@"url"] isKindOfClass:[NSNull class]] ? @"" : [dictionary objectForKey:@"url"]);
        self.verified = [[dictionary objectForKey:@"verified"] boolValue];
    }
    
    return self;
}

@end
