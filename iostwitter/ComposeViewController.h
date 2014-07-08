//
//  ComposeViewController.h
//  iostwitter
//
//  Created by Natarajan Kannan on 7/6/14.
//  Copyright (c) 2014 Y.CORP.YAHOO.COM\natarajk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"


@interface ComposeViewController : UIViewController <UITextViewDelegate>

@property (nonatomic) Tweet *inReplyToTweet;

@end
