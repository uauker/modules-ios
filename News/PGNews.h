//
//  PGNews.h
//  TestandoCustomizacao
//
//  Created by Uauker on 5/15/13.
//  Copyright (c) 2013 Uauker Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+PGDate.h"

@interface PGNews : NSObject

@property (nonatomic) int identifier;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *siteTitle;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSDate *createdAt;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
