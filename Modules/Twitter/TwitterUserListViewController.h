//
//  TwitterUserListViewController.h
//  Projeto Modules
//
//  Created by Uauker on 6/22/13.
//  Copyright (c) 2013 Uauker Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+SVPullToRefresh.h"
#import "TwitterHelper.h"
#import "TTUser+Parse.h"
#import "TweetCustomCell.h"
#import "TwitterUserTweetsViewController.h"

@interface TwitterUserListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

// Obrigatorio

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *listname;

@property (nonatomic, copy) NSString *navTitle;


// Opcional

@property (nonatomic, strong) UIColor *tableBackgroundColor;


// Privado

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, copy) NSArray *users;

@end
