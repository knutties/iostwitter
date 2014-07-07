//
//  TwitterUser.h
//  iostwitter
//
//  Created by Natarajan Kannan on 7/7/14.
//  Copyright (c) 2014 Y.CORP.YAHOO.COM\natarajk. All rights reserved.
//


#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface TwitterUser : MTLModel <MTLJSONSerializing>

@property (nonatomic) NSString *userHandle;
@property (nonatomic) NSString *userName;
@property (nonatomic) NSURL *userProfileURL;

- (NSString *) getUserHandleForDisplay;

@end
