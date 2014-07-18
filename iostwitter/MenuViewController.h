//
//  MenuViewController.h
//  iostwitter
//
//  Created by Natarajan Kannan on 7/16/14.
//  Copyright (c) 2014 Y.CORP.YAHOO.COM\natarajk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterClient.h"
#import "TwitterUser.h"
#import "UIImageView+AFNetworking.h"


@protocol MenuViewControllerDelegate <NSObject>

@required
- (void) resetTweetsViewController:(NSString *)name;

@end


@interface MenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign) id<MenuViewControllerDelegate> delegate;
@property (nonatomic) TwitterClient *client;
@property (nonatomic) TwitterUser *twitterUser;

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userHandleLabel;
@property (strong, nonatomic) IBOutlet UIView *profileHeaderView;

@end
