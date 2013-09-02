//
//  TwitterListViewController.h
//  Projeto Modules
//
//  Created by Uauker on 6/13/13.
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

@interface TwitterListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

// Obrigatorio

@property (nonatomic, copy) NSString *bundleCredentialFile;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *listname;

@property (nonatomic, copy) NSString *navTitle;


// Opcional

@property (nonatomic, strong) UIColor *tableBackgroundColor;


// Privado

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *tweets;

@end
