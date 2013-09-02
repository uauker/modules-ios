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
#import "TwitterHelper.h"

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
