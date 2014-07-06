//
//  User.h
//  iostwitter
//
//  Created by Natarajan Kannan on 7/5/14.
//  Copyright (c) 2014 Y.CORP.YAHOO.COM\natarajk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

+ (User *)currentUser;
+ (void)setCurrentUser:(User *) user;



@end
