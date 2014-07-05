//
//  TwitterClient.m
//  iostwitter
//
//  Created by Natarajan Kannan on 7/2/14.
//  Copyright (c) 2014 Y.CORP.YAHOO.COM\natarajk. All rights reserved.
//

#import "TwitterClient.h"

static NSString *const twitterBaseURL = @"https://api.twitter.com/";


@implementation TwitterClient

+ (TwitterClient *) instance:(NSString *)consumerKey consumerSecret:(NSString *)consumerSecret {
    
    static TwitterClient *instance = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:twitterBaseURL ]consumerKey:consumerKey consumerSecret:consumerSecret];
    });

    return instance;
}

- (void) login {
    NSLog(@"Twitter login called");
    
    [self.requestSerializer removeAccessToken];
    
    [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"POST" callbackURL:[NSURL URLWithString:@"cptwitter://oauth"] scope:nil success:^(BDBOAuthToken *requestToken) {
        NSLog(@"success %@", requestToken);
        
        NSString *authURL = [NSString stringWithFormat:@"%@oauth/authorize?oauth_token=%@",twitterBaseURL,requestToken.token];
        
        NSLog(@"auth url is %@", authURL);
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:authURL]];
        
    } failure:^(NSError *error) {
        NSLog(@"failure %@", error);
    }];
}

- (void) logout {
    [self.requestSerializer removeAccessToken];
}

- (AFHTTPRequestOperation *) homeTimeLineWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    return [self GET:@"1.1/statuses/home_timeline.json"
          parameters:nil success:success failure:failure];
}
@end
