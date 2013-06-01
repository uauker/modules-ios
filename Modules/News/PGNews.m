//
//  PGNews.m
//  TestandoCustomizacao
//
//  Created by Uauker on 5/15/13.
//  Copyright (c) 2013 Uauker Inc. All rights reserved.
//

#import "PGNews.h"

@implementation PGNews

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (self) {
        self.identifier = [[dictionary objectForKey:@"id"] integerValue];
        self.title = [dictionary objectForKey:@"title"];
        self.siteTitle = [dictionary objectForKey:@"site_title"];
        self.url = [dictionary objectForKey:@"url"];
        self.createdAt = [NSDate convert:[dictionary objectForKey:@"created_at"] withFormatter:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    }
    
    return self;
}

@end
