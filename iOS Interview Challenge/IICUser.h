//
//  IICUser.h
//  iOS Interview Challenge
//
//  Created by Bowen, Mike on 8/8/14.
//  Copyright (c) 2014 sandbox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IICUser : NSObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;

- (NSString*)usernameValidationError;
- (NSString*)passwordValidationError;

- (BOOL)isUserValid;

@end
