//
//  TwitterUserTweetsViewController.h
//  Projeto Modules
//
//  Created by Uauker on 6/21/13.
//  Copyright (c) 2013 Uauker Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterTweetViewController.h"
#import "UIScrollView+SVPullToRefresh.h"
#import "UIScrollView+SVInfiniteScrolling.h"
#import "TTUser+Parse.h"
#import "TTTweet+Parse.h"
#import "TweetCustomCell.h"
#import "STTwitterAPIWrapper.h"

#define K_TWITTER_CONSUMER_NAME @"Trânsito Rio"
#define K_TWITTER_CONSUMER_KEY @"WPDngmoDgU7SgRinKG5A"
#define K_TWITTER_CONSUMER_SECRET @"2fbdQ69bdHAkhRLsrLKjj9gvdtdxJsKB7jgosO45nE"
#define K_TWITTER_ACCESS_TOKEN @"25685569-SSMXlJ5SQqQ56u1DuedEDyikdQG9Uxc6y6hWGJ7gg"
#define K_TWITTER_ACCESS_TOKEN_SECRET @"Vuc8NqLOwFXLVcKGphKKuh3XZnc8M5vEj61VQMEpWQ"

@interface TwitterUserTweetsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

// Obrigatorio

@property (nonatomic, copy) NSString *navTitle;
@property (nonatomic, copy) NSString *screenName;


// Opcional

@property (nonatomic, strong) UIColor *tableBackgroundColor;


// Privado

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *tweets;

@end
