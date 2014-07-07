//
//  TweetCell.m
//  iostwitter
//
//  Created by Natarajan Kannan on 7/5/14.
//  Copyright (c) 2014 Y.CORP.YAHOO.COM\natarajk. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"


@implementation TweetCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) updateUIFromData {
    
    self.userNameLabel.text = self.tweet.userName;
    self.userHandleLabel.text = [self.tweet getUserHandleForDisplay];
    self.tweetLabel.text = self.tweet.tweetText;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yy"];
    NSString *str = [dateFormatter stringFromDate:self.tweet.createdAtDate];
    self.tweetTimeLabel.text = str;
    
    NSURL *userPhotoURL = self.tweet.userProfileURL;
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:userPhotoURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [self.userImageView setImageWithURLRequest:urlRequest placeholderImage:[UIImage imageNamed:@"1x1"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        self.userImageView.image = image;
        [UIView animateWithDuration:1.0 animations:^{
            self.userImageView.alpha = 1.0;
        }];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        // TODO - fall back to default url
        NSLog(@"Request failed with error: %@", error);
    }];
    

}

@end
