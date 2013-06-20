//
//  TwitterTweetViewController.h
//  Projeto Modules
//
//  Created by Uauker on 6/19/13.
//  Copyright (c) 2013 Uauker Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTAttributedLabel.h"
#import "TTTweet.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <QuartzCore/QuartzCore.h>
#import "TwitterText.h"

@interface TwitterTweetViewController : UIViewController <TTTAttributedLabelDelegate>

@property(nonatomic, strong) TTTweet *tweet;

@property (weak, nonatomic) IBOutlet UILabel *hours;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *twitterUser;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *text;

@end
