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
    
//    [twitter getListWithScreenName:self.username successBlock:^(NSArray *statuses) {
//        for (NSDictionary *dictionary in statuses) {
//            if ([[dictionary objectForKey:@"slug"] isEqualToString:self.listname]) {
//                self.listID = [dictionary objectForKey:@"id_str"];
//                break;
//            }
//        }
////        NSLog(@"%@", [statuses description]);
//    } errorBlock:^(NSError *error) {
//        //TODO: e o erro?
//    }];
    
    NSLog(@"%@, %@", self.listname, self.username);
    
    [twitter getListsMembersForSlug:@"transito-rj" ownerScreenName:@"uauker" orOwnerID:nil cursor:nil includeEntities:@(YES) skipStatus:@(NO) successBlock:^(NSArray *users, NSString *previousCursor, NSString *nextCursor) {
        NSLog(@"%@", [users description]);
    } errorBlock:^(NSError *error) {
        NSLog(@"error: %@", [error description]);        
    }];
     
//         getMembersListWithListName:self.listname ownerScreenName:self.username successBlock:^(NSArray *statuses) {
//        NSLog(@"%@", [statuses description]);
//    } errorBlock:^(NSError *error) {
//        NSLog(@"error: %@", [error description]);
//    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
