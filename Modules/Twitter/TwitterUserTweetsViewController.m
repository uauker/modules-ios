//
//  TwitterUserTweetsViewController.m
//  Projeto Modules
//
//  Created by Uauker on 6/21/13.
//  Copyright (c) 2013 Uauker Inc. All rights reserved.
//

#import "TwitterUserTweetsViewController.h"

@interface TwitterUserTweetsViewController () {
    NSTimer *tweetUpdateTime;
}

@end

@implementation TwitterUserTweetsViewController

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

    [self.navigationItem setTitle:self.navTitle];
//
//    [[self tableView] setBackgroundColor:self.tableBackgroundColor];
    
    [self setTweetUpdateTime];
    
    __block TwitterUserTweetsViewController *vc = self;
    __block NSMutableArray *tmpTweets;
    
    [self.tableView addPullToRefreshWithActionHandler:^{
        tmpTweets = [[NSMutableArray alloc] init];
        
        STTwitterAPIWrapper *twitter = [STTwitterAPIWrapper twitterAPIWithOAuthConsumerName:K_TWITTER_CONSUMER_NAME consumerKey:K_TWITTER_CONSUMER_KEY consumerSecret:K_TWITTER_CONSUMER_SECRET oauthToken:K_TWITTER_ACCESS_TOKEN oauthTokenSecret:K_TWITTER_ACCESS_TOKEN_SECRET];
        
        [twitter getUserTimelineWithScreenName:vc.screenName count:20 successBlock:^(NSArray *statuses) {
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
    
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        STTwitterAPIWrapper *twitter = [STTwitterAPIWrapper twitterAPIWithOAuthConsumerName:K_TWITTER_CONSUMER_NAME consumerKey:K_TWITTER_CONSUMER_KEY consumerSecret:K_TWITTER_CONSUMER_SECRET oauthToken:K_TWITTER_ACCESS_TOKEN oauthTokenSecret:K_TWITTER_ACCESS_TOKEN_SECRET];
        
        NSString *lastTweetId = [[vc.tweets lastObject] identifier];
        
        [twitter getUserTimelineWithScreenName:vc.screenName maxId:lastTweetId count:20 successBlock:^(NSArray *statuses) {
            for (NSDictionary *dictionary in statuses) {
                if (![lastTweetId isEqualToString:[dictionary objectForKey:@"id_str"]]) {
                    TTTweet *tweet = [[TTTweet alloc] initWithDictionary:dictionary];
                    [vc.tweets addObject:tweet];
                }
            }
            
            [vc.tableView reloadData];
            
            [vc.tableView.infiniteScrollingView stopAnimating];
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

- (void)dealloc {
    if (tweetUpdateTime) {
        [tweetUpdateTime invalidate];
        tweetUpdateTime = nil;
    }
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

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
//    
//    TTTweet *tweet = [self.tweets objectAtIndex:[indexPath row]];
//    
//    TwitterTweetViewController *tweetViewController = [[TwitterTweetViewController alloc] initWithNibName:@"TwitterTweetViewController" bundle:nil];
//    tweetViewController.tweet = tweet;
//    
//    [self.navigationController pushViewController:tweetViewController animated:YES];
//}

#pragma mark - Others

- (void)setTweetUpdateTime {
    if (!tweetUpdateTime) {
        tweetUpdateTime = [NSTimer scheduledTimerWithTimeInterval:(60.0)
                                                           target:self
                                                         selector:@selector(tableViewReload)
                                                         userInfo:nil
                                                          repeats:YES];
    }
}

- (void)tableViewReload {
    [self.tableView reloadData];
}

@end
