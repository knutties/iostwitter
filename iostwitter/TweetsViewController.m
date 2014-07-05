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


@interface TweetsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *tweets;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

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
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil]
         forCellReuseIdentifier:@"TweetCell"];
    
    self.tableView.rowHeight = 120;
    
    [self reloadTweets];
    [self setupPullToRefresh];
    

}

- (void) reloadTweets {
    TwitterClient *client = [TwitterClient instance:nil consumerSecret:nil];
    [client homeTimeLineWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"response is %@", responseObject);
        [self.refreshControl endRefreshing];

        NSError *error;
        self.tweets = [MTLJSONAdapter modelsOfClass:[Tweet class] fromJSONArray:responseObject error:&error];
        
        if (error) {
            NSLog(@"Couldn't deserealize app info data into JSON from NSData: %@", error);
            // TODO - retry
        } else {
            NSLog(@"mantle object array is %@", self.tweets);
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // TODO failed to load data - show retry
        NSLog(@"failed to get response");
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


#pragma mark - our table view implementation

- (int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // NSLog(@"cell for row %d", indexPath.row);
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = @"Hello World";
    return cell;
}


@end
