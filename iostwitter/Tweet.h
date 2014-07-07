//
//  Tweet.h
//  iostwitter
//
//  Created by Natarajan Kannan on 7/5/14.
//  Copyright (c) 2014 Y.CORP.YAHOO.COM\natarajk. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface Tweet : MTLModel <MTLJSONSerializing>

@property (nonatomic) NSNumber *id;
@property (nonatomic) NSString *id_str;
@property (nonatomic) NSString *userHandle;
@property (nonatomic) NSString *userName;
@property (nonatomic) NSString *tweetText;
@property (nonatomic) NSDate *createdAtDate;
@property (nonatomic) NSURL *userProfileURL;
@property (nonatomic) BOOL retweeted;
@property (nonatomic) NSNumber *retweetCount;
@property (nonatomic) NSNumber *favoriteCount;


- (NSString *) getUserHandleForDisplay;

@end
