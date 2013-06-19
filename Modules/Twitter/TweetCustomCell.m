//
//  TweetCustomCell.m
//  transitorio
//
//  Created by Uauker on 12/10/12.
//  Copyright (c) 2012 Uauker Inc. All rights reserved.
//

#import "TweetCustomCell.h"

@implementation TweetCustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.imageView.frame = CGRectMake(8, 8, 48, 48);
    float limgW =  self.imageView.image.size.width;
    
    if (limgW > 0) {
        self.textLabel.frame = CGRectMake(55,self.textLabel.frame.origin.y,self.textLabel.frame.size.width,self.textLabel.frame.size.height);
        self.detailTextLabel.frame = CGRectMake(55,self.detailTextLabel.frame.origin.y,self.detailTextLabel.frame.size.width,self.detailTextLabel.frame.size.height);
    }
}


- (void)load {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.imageView setImageWithURL:[NSURL URLWithString:[self.tweet.user profileImageUrl]]];
    self.imageView.layer.cornerRadius = 5.0;
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.borderColor = [UIColor blackColor].CGColor;
    self.imageView.layer.borderWidth = 0.5;
    
    self.username.text = [self.tweet.user name];
    
    self.date.text = [[self.tweet publishedAt] humanIntervalAgoSinceNow];
}

@end
