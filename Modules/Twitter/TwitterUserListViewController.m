//
//  TwitterUserListViewController.m
//  Projeto Modules
//
//  Created by Uauker on 6/22/13.
//  Copyright (c) 2013 Uauker Inc. All rights reserved.
//

#import "TwitterUserListViewController.h"

@interface TwitterUserListViewController ()

@end

@implementation TwitterUserListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    STTwitterAPI *twitter = [STTwitterAPI twitterAPIWithOAuthConsumerName:K_TWITTER_CONSUMER_NAME consumerKey:K_TWITTER_CONSUMER_KEY consumerSecret:K_TWITTER_CONSUMER_SECRET oauthToken:K_TWITTER_ACCESS_TOKEN oauthTokenSecret:K_TWITTER_ACCESS_TOKEN_SECRET];
    
    __block TwitterUserListViewController *vc = self;
    __block NSMutableArray *tmpUsers = [[NSMutableArray alloc] init];
    
    [self.tableView addPullToRefreshWithActionHandler:^{
        [twitter getListsMembersForSlug:self.listname ownerScreenName:self.username orOwnerID:nil cursor:nil includeEntities:@(NO) skipStatus:@(NO) successBlock:^(NSArray *users, NSString *previousCursor, NSString *nextCursor) {
            for (NSDictionary *dic in users) {
                TTUser *user = [[TTUser alloc] initWithDictionary:dic];
                [tmpUsers addObject:user];
            }
            
            vc.users = tmpUsers;

            if (vc.users && [vc.users count] > 0) {
                [vc.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
            }
            
            [vc.tableView reloadData];
            
            NSLog(@">>> %d", [users count]);
            
            [vc.tableView.pullToRefreshView stopAnimating];
        } errorBlock:^(NSError *error) {
            NSLog(@"error: %@", [error description]);
            
            [vc.tableView.pullToRefreshView stopAnimating];
        }];
    }];
    
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
    return [self.users count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"TweetCustomCell";
    
    TweetCustomCell *cell = (TweetCustomCell *) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
    	NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
    	cell = (TweetCustomCell *)[nib objectAtIndex:0];
    }
    
//    TTTweet *tweet = [self.users objectAtIndex:[indexPath row]];
    
//    [cell setTweet:tweet];
//    [cell load];
    
    //TextView
    UITextView *textView = (UITextView *)[cell viewWithTag:5];
    
    CGRect frame = textView.frame;
    frame.size.height = textView.contentSize.height;
    textView.frame = frame;
    
    return cell;
}

@end
