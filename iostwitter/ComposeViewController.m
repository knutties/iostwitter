//
//  ComposeViewController.m
//  iostwitter
//
//  Created by Natarajan Kannan on 7/6/14.
//  Copyright (c) 2014 Y.CORP.YAHOO.COM\natarajk. All rights reserved.
//

#import "ComposeViewController.h"
#import "TwitterClient.h"
#import "TwitterUser.h"
#import "UIImageView+AFNetworking.h"


@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *composeTextView;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userHandleLabel;
@property (nonatomic) TwitterClient *client;
@property (nonatomic) TwitterUser *twitterUser;

@end

@implementation ComposeViewController

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
    
    self.composeTextView.delegate = self;
    [[self.composeTextView layer] setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [[self.composeTextView layer] setBorderWidth:2];
    
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
        
        [self.userImageView setImageWithURLRequest:urlRequest placeholderImage:[UIImage imageNamed:@"1x1"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            self.userImageView.image = image;
            [UIView animateWithDuration:1.0 animations:^{
                self.userImageView.alpha = 1.0;
            }];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            // TODO - fall back to default url
            NSLog(@"Request failed with error: %@", error);
        }];
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed to get current user details, %@", error);
    }];
    
    UIBarButtonItem *tweetButton = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(postTweet)];
    self.navigationItem.rightBarButtonItem = tweetButton;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) postTweet {
    NSString *inReplyToTweetId = nil;
    
    if(self.inReplyToTweet != nil) {
        inReplyToTweetId = self.inReplyToTweet.id_str;
    }
    
    [self.client composeTweet:self.composeTextView.text inReplyTo:inReplyToTweetId success:^(AFHTTPRequestOperation *operation, NSError *error) {
        // TODO failed to load data - show retry
        NSLog(@"successfully posted tweet");
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed to post tweet, %@", error);
    }
     ];
}

# pragma - UITextView implementation
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    BOOL shouldChangeText = YES;
    
    if ([text isEqualToString:@"\n"]) {
        // Find the next entry field
        [textView resignFirstResponder];

        shouldChangeText = NO;
    }
    return shouldChangeText;
}
@end
