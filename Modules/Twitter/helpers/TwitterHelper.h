//
//  TwitterHelper.h
//  Projeto Modules
//
//  Created by Uauker on 9/2/13.
//  Copyright (c) 2013 Uauker Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STTwitter.h"

@interface TwitterHelper : NSObject {
}

@property (nonatomic, copy) NSString *consumerName;
@property (nonatomic, copy) NSString *consumerKey;
@property (nonatomic, copy) NSString *consumerSecret;
@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, copy) NSString *accessTokenSecret;


+ (TwitterHelper *)sharedInstance;

- (STTwitterAPI *)api;

@end
