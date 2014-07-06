//
//  User.m
//  iostwitter
//
//  Created by Natarajan Kannan on 7/5/14.
//  Copyright (c) 2014 Y.CORP.YAHOO.COM\natarajk. All rights reserved.
//

#import "User.h"

@implementation User

static User *currentUser = nil;

+ (User *)currentUser {
    
    if(currentUser == nil) {
        NSDictionary *dictionary = [[NSUserDefaults standardUserDefaults] objectForKey:@"current_user"];
        
        if(dictionary) {
            currentUser = [[User alloc] initWithDictionary:dictionary];
        }
        
    }
    
    return currentUser;
}

+ (void)setCurrentUser:(User *) user {
    currentUser = user;
    
    // save to nsuserdefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    
    //[[defaults setObject:user forKey:@"current_user"];
}

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [self init];
    if (self == nil) return nil;
    
    return self;
}

@end
