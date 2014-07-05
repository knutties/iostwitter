//
//  Tweet.m
//  iostwitter
//
//  Created by Natarajan Kannan on 7/5/14.
//  Copyright (c) 2014 Y.CORP.YAHOO.COM\natarajk. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    // model_property_name : json_field_name
    return @{
             @"userName" : @"user.name",
             @"userHandle" : @"user.screen_name",
             @"tweetText" : @"text"
             };
}

@end
