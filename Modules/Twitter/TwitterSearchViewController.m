//
//  TwitterSearchViewController.m
//  Projeto Modules
//
//  Created by Paulo Guilherme on 24/06/13.
//  Copyright (c) 2013 Uauker Inc. All rights reserved.
//

#import "TwitterSearchViewController.h"

@interface TwitterSearchViewController ()

@end

@implementation TwitterSearchViewController

- (void)initWithVariables {
    if (!self.locale) {
        self.locale = @"pt-BR";
    }
    
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
    
    __block TwitterSearchViewController *vc = self;
    __block NSMutableArray *tmpTweets;
    
    [self.tableView addPullToRefreshWithActionHandler:^{
        STTwitterAPIWrapper *twitter = [STTwitterAPIWrapper twitterAPIWithOAuthConsumerName:K_TWITTER_CONSUMER_NAME consumerKey:K_TWITTER_CONSUMER_KEY consumerSecret:K_TWITTER_CONSUMER_SECRET oauthToken:K_TWITTER_ACCESS_TOKEN oauthTokenSecret:K_TWITTER_ACCESS_TOKEN_SECRET];
        
        [twitter getSearchTweetsWithQuery:self.searchBar.text locale:@"pt-BR" successBlock:^(NSDictionary *searchMetadata, NSArray *statuses) {
            tmpTweets = [[NSMutableArray alloc] init];
            
            for (NSDictionary *dictionary in statuses) {
                TTTweet *tweet = [[TTTweet alloc] initWithDictionary:dictionary];
                [tmpTweets addObject:tweet];
            }
            
            vc.tweets = tmpTweets;
            
            [[self tableView] reloadData];
            
            [vc.tableView.pullToRefreshView stopAnimating];
        } errorBlock:^(NSError *error) {
            NSLog(@"%@", [error description]);
            
            [vc.tableView.pullToRefreshView stopAnimating];
        }];
    }];
    
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        STTwitterAPIWrapper *twitter = [STTwitterAPIWrapper twitterAPIWithOAuthConsumerName:K_TWITTER_CONSUMER_NAME consumerKey:K_TWITTER_CONSUMER_KEY consumerSecret:K_TWITTER_CONSUMER_SECRET oauthToken:K_TWITTER_ACCESS_TOKEN oauthTokenSecret:K_TWITTER_ACCESS_TOKEN_SECRET];
        
        NSString *lastTweetId = [[vc.tweets lastObject] identifier];
        
        [twitter getSearchTweetsWithQuery:self.searchBar.text maxID:lastTweetId successBlock:^(NSDictionary *searchMetadata, NSArray *statuses) {
            for (NSDictionary *dictionary in statuses) {
                if (![lastTweetId isEqualToString:[dictionary objectForKey:@"id_str"]]) {
                    TTTweet *tweet = [[TTTweet alloc] initWithDictionary:dictionary];
                    [vc.tweets addObject:tweet];
                }
            }
            
            [vc.tableView reloadData];
            
            [vc.tableView.infiniteScrollingView stopAnimating];
        } errorBlock:^(NSError *error) {
            NSLog(@"%@", [error description]);
            
            [vc.tableView.infiniteScrollingView stopAnimating];
        }];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.searchBar resignFirstResponder];
    [self.searchBar setShowsCancelButton:NO animated:YES];
}


#pragma mark - UISearchBar

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
    
    //Setando o botao cancelar
    UIButton *cancelButton = nil;
    for (UIView *subView in [[self searchBar] subviews]) {
        if ([subView isKindOfClass:UIButton.class]) {
            cancelButton = (UIButton*)subView;
        }
    }
    
    if (cancelButton) {
        [cancelButton setTitle:NSLocalizedString(@"cancel", nil) forState:UIControlStateNormal];
        [cancelButton sizeToFit];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
    [self.searchBar setShowsCancelButton:NO animated:YES];
    
//    [self initWithVariables];
    
    [self.tableView triggerPullToRefresh];
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
	[searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    [textField setText:@""];

    return YES;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
    
    TTTweet *tweet = [self.tweets objectAtIndex:[indexPath row]];
    
    TwitterTweetViewController *tweetViewController = [[TwitterTweetViewController alloc] initWithNibName:@"TwitterTweetViewController" bundle:nil];
    tweetViewController.tweet = tweet;
    tweetViewController.canAccessUserTweets = YES;
    
    [self.navigationController pushViewController:tweetViewController animated:YES];
}

@end
