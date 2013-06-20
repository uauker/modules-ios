//
//  TwitterTweetViewController.h
//  Projeto Modules
//
//  Created by Uauker on 6/19/13.
//  Copyright (c) 2013 Uauker Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTweet.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <QuartzCore/QuartzCore.h>

@interface TwitterTweetViewController : UIViewController

@property(nonatomic, strong) TTTweet *tweet;

@end
