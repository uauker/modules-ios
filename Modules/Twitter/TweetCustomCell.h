//
//  TweetCustomCell.h
//  transitorio
//
//  Created by Uauker on 12/10/12.
//  Copyright (c) 2012 Uauker Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <QuartzCore/QuartzCore.h>
#import "NSDate+HumanInterval.h"
#import "TTTweet.h"
#import "TTUser.h"

@interface TweetCustomCell : UITableViewCell

@property (nonatomic, strong) TTTweet *tweet;

@property (nonatomic, weak) IBOutlet UILabel *username;
@property (nonatomic, weak) IBOutlet UILabel *date;
@property (nonatomic, weak) IBOutlet UIImageView *image;
@property (nonatomic, strong) IBOutlet UITextView *textView;

- (void)load;
- (void)loadWithUser:(TTUser *)user;

@end