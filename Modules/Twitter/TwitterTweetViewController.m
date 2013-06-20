//
//  TwitterTweetViewController.m
//  Projeto Modules
//
//  Created by Uauker on 6/19/13.
//  Copyright (c) 2013 Uauker Inc. All rights reserved.
//

#import "TwitterTweetViewController.h"

@interface TwitterTweetViewController ()

@end

@implementation TwitterTweetViewController

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
    
    self.hours.text = self.tweet.toHourMinute;
    [self.profileImage setImageWithURL:[NSURL URLWithString:[self.tweet.user profileImageUrl]]];
    self.screenName.text = self.tweet.user.name;
    self.twitterUser.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenName];
    
    self.text.text = self.tweet.text;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
