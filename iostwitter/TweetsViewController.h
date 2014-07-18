//
//  HomeViewController.h
//  iostwitter
//
//  Created by Natarajan Kannan on 7/5/14.
//  Copyright (c) 2014 Y.CORP.YAHOO.COM\natarajk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterClient.h"
#import "MenuViewController.h"


@protocol TweetsViewControllerDelegate <NSObject>

@optional
- (void)movePanelLeft;
- (void)movePanelRight;

@required
- (void)movePanelToOriginalPosition;

@end


@interface TweetsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MenuViewControllerDelegate>
@property (nonatomic, assign) id<TweetsViewControllerDelegate> delegate;
@property (strong, nonatomic) NSArray *tweets;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic) TwitterClient *client;

- (id)initWithName:(NSString *)theName;
@end
