//
//  Tweet.m
//  iostwitter
//
//  Created by Natarajan Kannan on 7/5/14.
//  Copyright (c) 2014 Y.CORP.YAHOO.COM\natarajk. All rights reserved.
//

#import "Tweet.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"


@implementation Tweet

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    // model_property_name : json_field_name
    return @{
             @"userName" : @"user.name",
             @"userHandle" : @"user.screen_name",
             @"tweetText" : @"text",
             @"userPhotoURL": @"user.profile_image_url"
             };
}

+ (NSValueTransformer *)userPhotoURLJSONTransformer {
    // use Mantle's built-in "value transformer" to convert strings to NSURL and vice-versa
    // you can write your own transformers
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
