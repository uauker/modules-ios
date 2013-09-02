//
//  TwitterSearchViewController.h
//  Projeto Modules
//
//  Created by Paulo Guilherme on 24/06/13.
//  Copyright (c) 2013 Uauker Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterHelper.h"
#import "TweetCustomCell.h"
#import "TTTweet+Parse.h"
#import "UIScrollView+SVPullToRefresh.h"
#import "UIScrollView+SVInfiniteScrolling.h"
#import "TwitterTweetViewController.h"

@interface TwitterSearchViewController : UIViewController <UISearchDisplayDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

// Obrigatorio

@property (nonatomic, copy) NSString *navTitle;


// Opcional

@property (nonatomic, strong) UIColor *tableBackgroundColor;

@property (nonatomic, copy) NSString *locale;


// Privado

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *tweets;

@end
