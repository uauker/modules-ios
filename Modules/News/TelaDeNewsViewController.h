//
//  TelaDeNewsViewController.h
//  TestandoCustomizacao
//
//  Created by Uauker on 5/13/13.
//  Copyright (c) 2013 Uauker Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+SVPullToRefresh.h"
#import "EGOCache+PGCache.h"
#import "PGNews.h"
#import "NSDate+HumanInterval.h"
#import "TSMiniWebBrowser+PGBrowser.h"

@interface TelaDeNewsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, TSMiniWebBrowserDelegate>

@property (nonatomic, copy) NSString *site;
@property (nonatomic, copy) NSString *navTitle;

//

@property (nonatomic, strong) UIColor *tableBackgroundColor;
@property (nonatomic) float minimumTimeInSeconds;
@property (nonatomic) int cacheTimeInSeconds;

//

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, retain) NSArray *news;

@end
