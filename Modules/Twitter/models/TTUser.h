//
//  User.h
//  transitorio
//
//  Created by Uauker on 11/17/12.
//  Copyright (c) 2012 Uauker Inc. All rights reserved.
//

@interface TTUser : NSObject

@property (nonatomic, copy) NSString * identifier;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * profileBackgroundImageUrl;
@property (nonatomic, copy) NSString * profileImageUrl;
@property (nonatomic, copy) NSString * screenName;
@property (nonatomic, copy) NSString * text;
@property (nonatomic, copy) NSString * url;
@property (nonatomic) BOOL verified;


@end
