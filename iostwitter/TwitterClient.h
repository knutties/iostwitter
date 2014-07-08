//
//  TwitterClient.h
//  iostwitter
//
//  Created by Natarajan Kannan on 7/2/14.
//  Copyright (c) 2014 Y.CORP.YAHOO.COM\natarajk. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "AFHTTPRequestOperation.h"

@interface TwitterClient: BDBOAuth1RequestOperationManager

+ (TwitterClient *) instance:(NSString *)consumerKey consumerSecret:(NSString *)consumerSecret;

- (void) login;
- (void) logout;

- (AFHTTPRequestOperation *) homeTimeLineWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (AFHTTPRequestOperation *) currentUserDetails:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (AFHTTPRequestOperation *) composeTweet:(NSString *)status inReplyTo:(NSString*)inReplyTo success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (AFHTTPRequestOperation *) retweet:(NSString *)tweetId success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (AFHTTPRequestOperation *) favorite:(NSString *)tweetId success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
