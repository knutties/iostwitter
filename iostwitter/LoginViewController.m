//
//  LoginViewController.m
//  iostwitter
//
//  Created by Natarajan Kannan on 7/2/14.
//  Copyright (c) 2014 Y.CORP.YAHOO.COM\natarajk. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"

@interface LoginViewController ()
- (IBAction)onLogin:(id)sender;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLogin:(id)sender {
    NSString *consumerKey = NSLocalizedStringFromTable(@"consumerKey",  @"keys", @"comment");
    NSString *consumerSecret = NSLocalizedStringFromTable(@"consumerSecret",  @"keys", @"comment");
    
    [[TwitterClient instance:consumerKey consumerSecret:consumerSecret] login];
}
@end
