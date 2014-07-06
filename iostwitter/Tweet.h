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

@property (nonatomic) NSString *userHandle;
@property (nonatomic) NSString *userName;
@property (nonatomic) NSString *tweetText;
//@property (nonatomic) NSDate *createdAt;
@property (nonatomic) NSURL *userPhotoURL;

@end
