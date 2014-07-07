//
//  HomeViewController.m
//  iostwitter
//
//  Created by Natarajan Kannan on 7/5/14.
//  Copyright (c) 2014 Y.CORP.YAHOO.COM\natarajk. All rights reserved.
//

#import "TweetsViewController.h"
#import "TwitterClient.h"
#import "MTLJSONAdapter.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "ComposeViewController.h"
#import "TweetViewController.h"

@interface TweetsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *tweets;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic) TwitterClient *client;


@end

@implementation TweetsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Home";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.client = [TwitterClient instance:nil consumerSecret:nil];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil]
         forCellReuseIdentifier:@"TweetCell"];
    
    self.tableView.rowHeight = 120;
    
    [self reloadTweets];
    [self setupPullToRefresh];
    
    // setup right navigation button
    UIBarButtonItem *composeButton = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(loadComposeViewController)];
    self.navigationItem.rightBarButtonItem = composeButton;
    
}

- (void)loadComposeViewController {
    
    // setup back button for child view controller
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:nil action:nil];

    ComposeViewController *composeViewController = [[ComposeViewController alloc] init];
    [self.navigationController pushViewController:composeViewController animated:YES];

}

- (void) loadTweetViewController {
}

- (void) reloadTweets {

    [self.client homeTimeLineWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSLog(@"response is %@", responseObject);
        [self.refreshControl endRefreshing];

        NSError *error;
        self.tweets = [MTLJSONAdapter modelsOfClass:[Tweet class] fromJSONArray:responseObject error:&error];
        
        if (error) {
            NSLog(@"Couldn't deserealize app info data into JSON from NSData: %@", error);
            // TODO - retry
        } else {
            // NSLog(@"mantle object array is %@", self.tweets);
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // TODO failed to load data - show retry
        NSLog(@"failed to get response - %@", error);
        [self.refreshControl endRefreshing];
    }];
}

- (void) setupPullToRefresh {
    // setup pull-to-refresh
    UITableViewController *tableViewController = [[UITableViewController alloc] init];
    tableViewController.tableView = self.tableView;
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(reloadTweets) forControlEvents:UIControlEventValueChanged];
    tableViewController.refreshControl = self.refreshControl;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        // back button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
        [self.client logout];
    }
    [super viewWillDisappear:animated];
}

#pragma mark - our table view implementation

- (int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    cell.tweet = self.tweets[indexPath.row];
    [cell updateUIFromData];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // NSLog(@"Navigation Controller: %@", self.navigationController);
    TweetCell *selectedCell = [tableView cellForRowAtIndexPath: indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // setup back button for child view controller
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    TweetViewController *tweetViewController = [[TweetViewController alloc] init];
    tweetViewController.tweet = selectedCell.tweet;
    [self.navigationController pushViewController:tweetViewController animated:YES];
    
}



@end
