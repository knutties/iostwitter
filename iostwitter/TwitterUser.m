//
//  TwitterUser.m
//  iostwitter
//
//  Created by Natarajan Kannan on 7/7/14.
//  Copyright (c) 2014 Y.CORP.YAHOO.COM\natarajk. All rights reserved.
//

#import "TwitterUser.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"
#import "MTLValueTransformer.h"

@implementation TwitterUser

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    // model_property_name : json_field_name
    return @{
             @"userName" : @"name",
             @"userHandle" : @"screen_name",
             @"userProfileURL": @"profile_image_url",
             };
}

+ (NSValueTransformer *)userProfileURLJSONTransformer {
    // use Mantle's built-in "value transformer" to convert strings to NSURL and vice-versa
    // you can write your own transformers
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

- (NSString *) getUserHandleForDisplay {
    return [NSString stringWithFormat:@"@%@", self.userHandle];
}

@end
