//
//  TelaDeNewsViewController.m
//  TestandoCustomizacao
//
//  Created by Uauker on 5/13/13.
//  Copyright (c) 2013 Uauker Inc. All rights reserved.
//

#import "TelaDeNewsViewController.h"

@interface TelaDeNewsViewController ()

@end

@implementation TelaDeNewsViewController

- (void)initWithVariables {
    if (!self.tableBackgroundColor) {
        self.tableBackgroundColor = [UIColor colorWithRed:238/255.f green:238/255.f blue:238/255.f alpha:1.0];
    }
    
    if (!self.minimumTimeInSeconds) {
        self.minimumTimeInSeconds = 1.5;
    }
    
    if (!self.cacheTimeInSeconds) {
        self.cacheTimeInSeconds = 5 * 60;
    }
}

- (void)loadView
{
    [super loadView];
    
    [self initWithVariables];
    
    NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"TelaDeNews" owner:self options:nil];
    self.view = [nibObjects objectAtIndex:0];
    
    self.tableView = (UITableView *)[self.view viewWithTag:1];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setTitle:self.navTitle];
    
    [[self tableView] setBackgroundColor:self.tableBackgroundColor];

    __block TelaDeNewsViewController *vc = self;
    __block NSMutableArray *tmpArrayNews = [[NSMutableArray alloc] init];
    
    [self.tableView addPullToRefreshWithActionHandler:^{
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, vc.minimumTimeInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [EGOCache setUrl:vc.site withTimeoutInterval:vc.cacheTimeInSeconds onSuccessPerform:^(NSString *content, BOOL isNew, NSError *error) {
                tmpArrayNews = [[NSMutableArray alloc] init];
                
                if (error == nil && (isNew || vc.news == nil)) {
                    NSDictionary *dic = [content objectFromJSONString];

                    for (NSDictionary *item in [dic objectForKey:@"news"]) {
                        PGNews *localNews = [[PGNews alloc] initWithDictionary:item];
                        [tmpArrayNews addObject:localNews];
                    }

                    vc.news = tmpArrayNews;
                }
            }];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [vc.tableView reloadData];

                [vc.tableView.pullToRefreshView stopAnimating];
            });
        });
    }];
    
    [self.tableView triggerPullToRefresh];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if ([EGOCache hasCacheMD5ForKey:self.site] && self.news && [self.news count] > 0) {
        return ;
    }
    
    [self.tableView triggerPullToRefresh];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.news count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"PGNewsCell";
    
    UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
    	NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
    	cell = (UITableViewCell *)[nib objectAtIndex:0];
    }
    
    PGNews *pgNews = [self.news objectAtIndex:[indexPath row]];
    
    UILabel *sourceView = (UILabel *)[cell viewWithTag:3];
    UILabel *textView = (UILabel *)[cell viewWithTag:2];
    UILabel *dateView = (UILabel *)[cell viewWithTag:1];
    
    sourceView.text = pgNews.siteTitle;
    textView.text = pgNews.title;
    dateView.text = [pgNews.createdAt humanIntervalAgoSinceNow];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 119;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
    
    PGNews *oneNews = [self.news objectAtIndex:[indexPath row]];
    
    TSMiniWebBrowser *webBrowser = [TSMiniWebBrowser browserWithUrl:[NSURL URLWithString:oneNews.url] delegate:self];
    
    [self.navigationController pushViewController:webBrowser animated:YES];
}

@end
