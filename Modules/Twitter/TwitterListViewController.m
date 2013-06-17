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
        STTwitterAPIWrapper *twitter = [STTwitterAPIWrapper twitterAPIWithOAuthConsumerName:K_TWITTER_CONSUMER_NAME consumerKey:K_TWITTER_CONSUMER_KEY consumerSecret:K_TWITTER_CONSUMER_SECRET oauthToken:K_TWITTER_ACCESS_TOKEN oauthTokenSecret:K_TWITTER_ACCESS_TOKEN_SECRET];
        
        [twitter getUserListWithListName:vc.listname ownerScreenName:vc.username successBlock:^(NSArray *statuses) {
            for (NSDictionary *dictionary in statuses) {
                TTTweet *tweet = [[TTTweet alloc] initWithDictionary:dictionary];
                [tmpTweets addObject:tweet];
            }
            
            vc.tweets = tmpTweets;
            
            [vc.tableView reloadData];
            
            [vc.tableView.pullToRefreshView stopAnimating];
        } errorBlock:^(NSError *error) {
            //TODO: deu problema, e ai?
            NSLog(@"deu xabu: %@", [error description]);
            
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
    return [self.tweets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"TweetCustomCell";
    
    TweetCustomCell *cell = (TweetCustomCell *) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
    	NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
    	cell = (TweetCustomCell *)[nib objectAtIndex:0];
    }
    
    TTTweet *tweet = [self.tweets objectAtIndex:[indexPath row]];
    
    [cell setTweet:tweet];
    [cell load];
    
    //TextView
    UITextView *textView = (UITextView *)[cell viewWithTag:5];
    
    if (!textView) {
        textView = [[UITextView alloc] initWithFrame:CGRectMake(58.0f, 23.0f, 251.0f, 100.0f)];
        textView.backgroundColor = [UIColor clearColor];
        textView.tag = 5;
        textView.editable = NO;
        textView.scrollEnabled = NO;
        textView.userInteractionEnabled = NO;
        textView.dataDetectorTypes = UIDataDetectorTypeNone;
    }
    
    NSDictionary *attributes = [[NSDictionary alloc] initWithObjectsAndKeys:
                                [UIFont systemFontOfSize:14], NSFontAttributeName,
                                [UIColor colorWithRed:43/255.f green:46/255.f blue:47/255.f alpha:1.0], NSForegroundColorAttributeName, nil];
    
    textView.attributedText = [[NSMutableAttributedString alloc] initWithString:tweet.text attributes:attributes];
    
    [cell.contentView addSubview:textView];
    CGRect frame = textView.frame;
    frame.size.height = textView.contentSize.height;
    textView.frame = frame;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    UITextView *textView = (UITextView *)[cell viewWithTag:5];
    int partialCellSize = (textView.frame.size.height < 35) ? 38 : textView.frame.size.height;
    
    return 27 + partialCellSize;
}

@end
