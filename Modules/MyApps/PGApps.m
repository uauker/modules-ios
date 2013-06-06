//
//  PGApps.m
//  Projeto Modules
//
//  Created by Uauker on 6/2/13.
//  Copyright (c) 2013 Uauker Inc. All rights reserved.
//

#import "PGApps.h"

@implementation PGApps

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (self) {
        self.name = [dictionary objectForKey:@"name"];
        self.icon = [dictionary objectForKey:@"icon"];
        self.category = [dictionary objectForKey:@"category"];
        self.bundle = [dictionary objectForKey:@"bundle"];
        self.url = [dictionary objectForKey:@"url"];
    }
    
    return self;
}

@end
