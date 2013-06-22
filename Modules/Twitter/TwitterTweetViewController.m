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

- (void)initWithVariables {
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
    
    [self.navigationItem setTitle:self.tweet.user.name];
    
    self.hours.text = self.tweet.toHourMinute;
    [self.profileImage setImageWithURL:[NSURL URLWithString:[self.tweet.user profileImageUrl]]];
    self.screenName.text = self.tweet.user.name;
    self.twitterUser.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenName];
    
    [self.text setAttributedText:[self coloringWithTweet:[self.tweet text]]];
    self.text.delegate = self;
    
    [self.text setNumberOfLines:0];
    [self.text sizeToFit];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Tweet Color

- (NSAttributedString *)coloringWithTweet:(NSString *)tweet {
    CGFloat leading = 3.0;
    CTTextAlignment alignment = kCTLeftTextAlignment;
    const CTParagraphStyleSetting styleSettings[] = {
        {kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof(CGFloat), &leading},
        {kCTParagraphStyleSpecifierAlignment, sizeof(CTTextAlignment), &alignment}
    };
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(styleSettings, 2);
    
    NSDictionary *attributes = [[NSDictionary alloc] initWithObjectsAndKeys:
                                [UIFont systemFontOfSize:17], NSFontAttributeName,
                                paragraphStyle, kCTParagraphStyleAttributeName, nil];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self.tweet.text attributes:attributes];
    
    NSArray *entities = [TwitterText entitiesInText:self.tweet.text];
    
    for (TwitterTextEntity *entity in entities) {
        UIColor *color = nil;
        
        if (entity.type == 0) { //URL
            color = [UIColor colorWithRed:45/255.f green:113/255.f blue:178/255.f alpha:1];
            
            NSString *urlString = [self.tweet.text substringWithRange:entity.range];
            NSTextCheckingResult *check = [NSTextCheckingResult linkCheckingResultWithRange:entity.range URL:[NSURL URLWithString:urlString]];
            [self.text addLinkWithTextCheckingResult:check attributes:nil];
        }
        
        if (entity.type == 1) { //ScreenName
            color = [UIColor colorWithRed:71/255.f green:90/255.f blue:109/255.f alpha:1];
            [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:17] range:entity.range];
        }
        
        if (entity.type == 2) { //Hashtag
            color = [UIColor colorWithRed:151/255.f green:154/255.f blue:158/255.f alpha:1];
        }
        
        if (color) {
            [string addAttribute:NSForegroundColorAttributeName value:color range:entity.range];
        }
    }
    
    return string;
}

#pragma mark TTTAttributedLabel

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url {
    if ([[url scheme] containsString:@"http"]) {
        TSMiniWebBrowser *webBrowser = [TSMiniWebBrowser browserWithUrl:url delegate:self];
        [self.navigationController pushViewController:webBrowser animated:YES];
    }
}

- (IBAction)touchUpInsideInUsername:(id)sender {
    if (![self canAccessUserTweets]) {
        return ;
    }
    
    TwitterUserTweetsViewController *twitterUserTweetsViewController = [[TwitterUserTweetsViewController alloc] initWithNibName:@"TwitterUserTweetsViewController" bundle:nil];
    twitterUserTweetsViewController.screenName = [[self.tweet user] screenName];
    
    [self.navigationController pushViewController:twitterUserTweetsViewController animated:YES];
}

@end
