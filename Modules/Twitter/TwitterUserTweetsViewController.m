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

- (void)initWithVariables {
    if (!self.tableBackgroundColor) {
        self.tableBackgroundColor = [UIColor colorWithRed:238/255.f green:238/255.f blue:238/255.f alpha:1.0];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initWithVariables];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.navigationItem setTitle:self.navTitle];

    [[self tableView] setBackgroundColor:self.tableBackgroundColor];
    
    [self setTweetUpdateTime];
    
    __block TwitterUserTweetsViewController *vc = self;
    __block NSMutableArray *tmpTweets;
    
    [self.tableView addPullToRefreshWithActionHandler:^{
        tmpTweets = [[NSMutableArray alloc] init];
        
        STTwitterAPI *twitter = [[TwitterHelper sharedInstance] api];
        
        [twitter getUserTimelineWithScreenName:vc.screenName count:20 successBlock:^(NSArray *statuses) {
            for (NSDictionary *dictionary in statuses) {
                TTTweet *tweet = [[TTTweet alloc] initWithDictionary:dictionary];
                [tmpTweets addObject:tweet];
            }
            
            vc.tweets = tmpTweets;
            
            if (vc.tweets && [vc.tweets count] > 0) {
                [vc.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
            }
            
            [vc.tableView reloadData];
            
            [vc.tableView.pullToRefreshView stopAnimating];
        } errorBlock:^(NSError *error) {
            //TODO: deu problema, e ai?
            NSLog(@"deu xabu: %@", [error description]);
            
            [vc.tableView.pullToRefreshView stopAnimating];
        }];
    }];
    
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        STTwitterAPI *twitter = [[TwitterHelper sharedInstance] api];
        
        NSString *lastTweetId = [[vc.tweets lastObject] identifier];
        
        [twitter getUserTimelineWithScreenName:vc.screenName sinceID:nil maxID:lastTweetId count:20 successBlock:^(NSArray *statuses) {
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

            [vc.tableView.infiniteScrollingView stopAnimating];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
    
    TTTweet *tweet = [self.tweets objectAtIndex:[indexPath row]];
    
    TwitterTweetViewController *tweetViewController = [[TwitterTweetViewController alloc] initWithNibName:@"TwitterTweetViewController" bundle:nil];
    tweetViewController.tweet = tweet;
    tweetViewController.canAccessUserTweets = NO;
    
    [self.navigationController pushViewController:tweetViewController animated:YES];
}

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
