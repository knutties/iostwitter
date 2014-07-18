//
//  MenuViewController.m
//  iostwitter
//
//  Created by Natarajan Kannan on 7/16/14.
//  Copyright (c) 2014 Y.CORP.YAHOO.COM\natarajk. All rights reserved.
//

#import "MenuViewController.h"


@interface MenuViewController ()
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (nonatomic, strong) NSArray *menuItems;
@end

@implementation MenuViewController

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
    
    self.menuTableView.delegate = self;
    self.menuTableView.dataSource = self;
    
    self.menuTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.menuItems = @[@"home", @"user"];
    
    NSString *consumerKey = NSLocalizedStringFromTable(@"consumerKey",  @"keys", @"comment");
    NSString *consumerSecret = NSLocalizedStringFromTable(@"consumerSecret",  @"keys", @"comment");
    self.client = [TwitterClient instance:consumerKey consumerSecret:consumerSecret];
    
    [self.client currentUserDetails:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"got current user details %@", responseObject);
        NSError *error;
        self.twitterUser = [MTLJSONAdapter modelOfClass:[TwitterUser class] fromJSONDictionary:responseObject error:&error];
        
        self.userNameLabel.text = self.twitterUser.userName;
        self.userHandleLabel.text = [self.twitterUser getUserHandleForDisplay];
        NSURL *userProfileURL = self.twitterUser.userProfileURL;
        
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:userProfileURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        
        [self.profileImageView setImageWithURLRequest:urlRequest placeholderImage:[UIImage imageNamed:@"1x1"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            self.profileImageView.image = image;
            [UIView animateWithDuration:1.0 animations:^{
                self.profileHeaderView.alpha = 1.0;
            }];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            // TODO - fall back to default url
            NSLog(@"Request failed with error: %@", error);
        }];
        
        [self.menuTableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed to get current user details, %@", error);
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = self.menuItems[indexPath.row];
    return cell;

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.profileHeaderView.frame = CGRectMake(0, 0, tableView.frame.size.width, 125);
    return self.profileHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 125;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath: indexPath];
    NSLog(@"selecting cell %@", cell.textLabel.text);

    
    [_delegate resetTweetsViewController:cell.textLabel.text];
}


@end
