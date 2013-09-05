//
//  PGApps.h
//  Projeto Modules
//
//  Created by Uauker on 6/2/13.
//  Copyright (c) 2013 Uauker Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PGApps : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *bundle;
@property (nonatomic, copy) NSString *url;
@property (nonatomic) BOOL *active;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
