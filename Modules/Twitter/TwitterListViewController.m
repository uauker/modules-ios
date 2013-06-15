//
//  TwitterListViewController.m
//  Projeto Modules
//
//  Created by Uauker on 6/13/13.
//  Copyright (c) 2013 Uauker Inc. All rights reserved.
//

#import "TwitterListViewController.h"

@interface TwitterListViewController ()

@end

@implementation TwitterListViewController

- (void)initWithVariables {
    if (!self.minimumTimeInSeconds) {
        self.minimumTimeInSeconds = 1.5;
    }
}

- (void)loadView
{
    [super loadView];
    
    [self initWithVariables];
    
    NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"TwitterListView" owner:self options:nil];
    self.view = [nibObjects objectAtIndex:0];
    
    self.tableView = (UITableView *)[self.view viewWithTag:1];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    __block TwitterListViewController *vc = self;
    __block NSMutableArray *tmpTweets = [[NSMutableArray alloc] init];
    
    [self.tableView addPullToRefreshWithActionHandler:^{
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, vc.minimumTimeInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                STTwitterAPIWrapper *twitter = [STTwitterAPIWrapper twitterAPIWithOAuthConsumerName:K_TWITTER_CONSUMER_NAME consumerKey:K_TWITTER_CONSUMER_KEY consumerSecret:K_TWITTER_CONSUMER_SECRET oauthToken:K_TWITTER_ACCESS_TOKEN oauthTokenSecret:K_TWITTER_ACCESS_TOKEN_SECRET];
                
                [twitter getUserListWithListName:@"transito-rj" ownerScreenName:@"uauker" successBlock:^(NSArray *statuses) {
                    for (NSDictionary *dictionary in statuses) {
                        TTTweet *tweet = [[TTTweet alloc] initWithDictionary:dictionary];
                        [tmpTweets addObject:tweet];
                    }
                    
                    [vc.tableView reloadData];
                } errorBlock:^(NSError *error) {
                    //TODO: deu problema, e ai?
                    NSLog(@"deu xabu: %@", [error description]);
                }];
                
                [vc.tableView.pullToRefreshView stopAnimating];
            });
        });
    }];
    
    if (tmpTweets) {
        self.tweets = tmpTweets;
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
    return [self.tweets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"PGNewsCell";
    
    UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
    	NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
    	cell = (UITableViewCell *)[nib objectAtIndex:0];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 119;
}

@end
