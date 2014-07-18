//
//  TweetViewController.m
//  iostwitter
//
//  Created by Natarajan Kannan on 7/7/14.
//  Copyright (c) 2014 Y.CORP.YAHOO.COM\natarajk. All rights reserved.
//

#import "TweetViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"
#import "ComposeViewController.h"


@interface TweetViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userHandleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoriteLabel;
- (IBAction)onRetweet:(id)sender;
- (IBAction)onFavorite:(id)sender;
- (IBAction)onReply:(id)sender;
@property (nonatomic) TwitterClient *client;


@end

@implementation TweetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Tweet";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self updateUIFromData];
    NSString *consumerKey = NSLocalizedStringFromTable(@"consumerKey",  @"keys", @"comment");
    NSString *consumerSecret = NSLocalizedStringFromTable(@"consumerSecret",  @"keys", @"comment");
    self.client = [TwitterClient instance:consumerKey consumerSecret:consumerSecret];
        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updateUIFromData {
        self.userNameLabel.text = self.tweet.userName;
        self.userHandleLabel.text = [self.tweet getUserHandleForDisplay];
        self.tweetLabel.text = self.tweet.tweetText;
        self.retweetLabel.text = [NSString stringWithFormat:@"%@", self.tweet.retweetCount];
        self.favoriteLabel.text = [NSString stringWithFormat:@"%@", self.tweet.favoriteCount];
    
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM/dd/yy HH:mm "];
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

- (IBAction)onRetweet:(id)sender {
    [self.client retweet:self.tweet.id_str success:^(AFHTTPRequestOperation *operation, NSError *error) {
        // TODO failed to load data - show retry
        NSLog(@"successfully retweeted tweet %@", self.tweet.id_str);
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed to retweet tweet %@, reason %@", self.tweet.id_str, error);
    }
     ];
}

- (IBAction)onFavorite:(id)sender {
    NSLog(@"calling onFavorite method");
    [self.client favorite:self.tweet.id_str success:^(AFHTTPRequestOperation *operation, NSError *error) {
        // TODO failed to load data - show retry
        NSLog(@"successfully favorited tweet %@", self.tweet.id_str);
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed to favorite tweet %@, reason %@", self.tweet.id_str, error);
    }
     ];
}

- (IBAction)onReply:(id)sender {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    ComposeViewController *composeViewController = [[ComposeViewController alloc] init];
    composeViewController.inReplyToTweet = self.tweet;
    [self.navigationController pushViewController:composeViewController animated:NO];
    
}
@end
