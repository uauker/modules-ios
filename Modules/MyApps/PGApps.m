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
        self.active = [dictionary objectForKey:@"active"];
    }
    
    return self;
}

- (BOOL)isActived {
    return [self.active boolValue];
}

- (void) encodeWithCoder:(NSCoder*)encoder {
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.icon forKey:@"icon"];
    [encoder encodeObject:self.category forKey:@"category"];
    [encoder encodeObject:self.bundle forKey:@"bundle"];
    [encoder encodeObject:self.url forKey:@"url"];    
//    [encoder encodeBool:*(self.active) forKey:@"active"];
}

- (id) initWithCoder:(NSCoder*)decoder {
    if (self = [super init]) {
        self.name = [decoder decodeObjectForKey:@"name"];
        self.icon = [decoder decodeObjectForKey:@"icon"];
        self.category = [decoder decodeObjectForKey:@"category"];
        self.bundle = [decoder decodeObjectForKey:@"bundle"];
        self.url = [decoder decodeObjectForKey:@"url"];
//        self.active = [decoder decodeBoolForKey:@"active"];
    }
    return self;
}

@end
