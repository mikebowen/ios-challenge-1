//
//  IICUser.m
//  iOS Interview Challenge
//
//  Created by Bowen, Mike on 8/8/14.
//  Copyright (c) 2014 sandbox. All rights reserved.
//

#import "IICUser.h"

NSUInteger const kUsernameMinimumLength = 8;
NSUInteger const kPaswordMinimumLength = 8;

@implementation IICUser

- (id)init
{
    self = [super init];
    if (self != nil)
    {
        _username = @"";
        _password = @"";
    }
    return self;
}

- (NSString*)usernameValidationError
{
    if(self.username.length < kUsernameMinimumLength)
    {
        return @"Username must be at least 8 characters long.";
    }
    
    // Check that username is only upper or lowercase alpha characters
    NSString *regEx = @"[a-zA-Z]*";
    NSPredicate *alphaPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
    if(![alphaPredicate evaluateWithObject:self.username])
    {
        return @"Username must be alpha characters only.";
    }
    
    return nil;
}

- (NSString*)passwordValidationError
{
    if(self.password.length < kPaswordMinimumLength)
    {
        return @"Password must be at least 8 characters long.";
    }
    
    return nil;
}

- (BOOL)isUserValid
{
    if(([self passwordValidationError] == nil) &&
       ([self usernameValidationError] == nil))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end
