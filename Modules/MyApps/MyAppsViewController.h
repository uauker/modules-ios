//
//  MyAppsViewController.h
//  Projeto Modules
//
//  Created by Uauker on 6/2/13.
//  Copyright (c) 2013 Uauker Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "EGOCache+PGCache.h"
#import "PGApps.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define URL_HEROKU_MY_APPS @"http://www.uauker.com/api/apps/v1/ios.json"

@interface MyAppsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSString *navTitle;

//

@property (nonatomic, strong) UIColor *tableBackgroundColor;
@property (nonatomic) int cacheTimeInSeconds;

//

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, retain) NSArray *apps;

@end
