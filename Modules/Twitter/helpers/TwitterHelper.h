//
//  TwitterHelper.h
//  Projeto Modules
//
//  Created by Uauker on 9/2/13.
//  Copyright (c) 2013 Uauker Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STTwitter.h"

#define K_TWITTER_CONSUMER_NAME @"Trânsito Rio"
#define K_TWITTER_CONSUMER_KEY @"WPDngmoDgU7SgRinKG5A"
#define K_TWITTER_CONSUMER_SECRET @"2fbdQ69bdHAkhRLsrLKjj9gvdtdxJsKB7jgosO45nE"
#define K_TWITTER_ACCESS_TOKEN @"25685569-SSMXlJ5SQqQ56u1DuedEDyikdQG9Uxc6y6hWGJ7gg"
#define K_TWITTER_ACCESS_TOKEN_SECRET @"Vuc8NqLOwFXLVcKGphKKuh3XZnc8M5vEj61VQMEpWQ"

@interface TwitterHelper : NSObject

+ (STTwitterAPI *)instanceAPI;

@end
