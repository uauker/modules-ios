//
//  MyAppsViewController.h
//  Projeto Modules
//
//  Created by Uauker on 6/23/13.
//  Copyright (c) 2013 Uauker Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "EGOCache+PGCache.h"
#import "PGApps.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIScrollView+SVPullToRefresh.h"

#define URL_HEROKU_MY_APPS @"http://www.uauker.com/api/apps/v1/ios.json"

@interface MyAppsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

// Obrigatorio

@property (nonatomic, copy) NSString *navTitle;


// Opcional

@property (nonatomic, strong) UIColor *tableBackgroundColor;
@property (nonatomic) float minimumTimeInSeconds;
@property (nonatomic) int cacheTimeInSeconds;


// Privado

@property (nonatomic, retain) NSArray *apps;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
