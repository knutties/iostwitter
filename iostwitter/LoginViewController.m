//
//  LoginViewController.m
//  iostwitter
//
//  Created by Natarajan Kannan on 7/2/14.
//  Copyright (c) 2014 Y.CORP.YAHOO.COM\natarajk. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"
#import "TweetsViewController.h"

@interface LoginViewController ()
- (IBAction)onLogin:(id)sender;

@property (nonatomic) TwitterClient *client;

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:nil action:nil];

    // style the navigation bar
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.333 green:0.6745 blue:0.933 alpha:1.0];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];


    NSString *consumerKey = NSLocalizedStringFromTable(@"consumerKey",  @"keys", @"comment");
    NSString *consumerSecret = NSLocalizedStringFromTable(@"consumerSecret",  @"keys", @"comment");
    self.client = [TwitterClient instance:consumerKey consumerSecret:consumerSecret];

    
    if(self.client.requestSerializer.accessToken != nil) {
        // we have an access token - try fetching tweets
        TweetsViewController *tweetsViewController = [[TweetsViewController alloc] init];
        [self.navigationController pushViewController:tweetsViewController animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLogin:(id)sender {
    [self.client login];
}

@end
