//
//  TwitterSearchViewController.h
//  Projeto Modules
//
//  Created by Paulo Guilherme on 24/06/13.
//  Copyright (c) 2013 Uauker Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STTwitterAPIWrapper.h"
#import "TweetCustomCell.h"
#import "TTTweet+Parse.h"
#import "UIScrollView+SVPullToRefresh.h"
#import "UIScrollView+SVInfiniteScrolling.h"

#define K_TWITTER_CONSUMER_NAME @"Trânsito Rio"
#define K_TWITTER_CONSUMER_KEY @"WPDngmoDgU7SgRinKG5A"
#define K_TWITTER_CONSUMER_SECRET @"2fbdQ69bdHAkhRLsrLKjj9gvdtdxJsKB7jgosO45nE"
#define K_TWITTER_ACCESS_TOKEN @"25685569-SSMXlJ5SQqQ56u1DuedEDyikdQG9Uxc6y6hWGJ7gg"
#define K_TWITTER_ACCESS_TOKEN_SECRET @"Vuc8NqLOwFXLVcKGphKKuh3XZnc8M5vEj61VQMEpWQ"

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
