//
//  ContentViewController.h
//  iostwitter
//
//  Created by Natarajan Kannan on 7/16/14.
//  Copyright (c) 2014 Y.CORP.YAHOO.COM\natarajk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetsViewController.h"
#import "MenuViewController.h"



@interface ContentViewController : UIViewController <UIGestureRecognizerDelegate, TweetsViewControllerDelegate, MenuViewControllerDelegate>
@property (nonatomic, assign) BOOL showingLeftPanel;
@end
