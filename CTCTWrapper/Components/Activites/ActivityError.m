//
//  ActivityError.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "ActivityError.h"

@implementation ActivityError

- (id)init
{
    if (self = [super init])
    {
        _message = @"";
        _lineNumber = @"";
        _emailAddress = @"";
    }
    
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _message = [Component valueForDictionary:dictionary withKey:@"message"];
        _lineNumber = [Component valueForDictionary:dictionary withKey:@"line_number"];
        _emailAddress = [Component valueForDictionary:dictionary withKey:@"email_address"];
    }
    
    return self;
}

+ (ActivityError *)activityErrorWithDictionary:(NSDictionary *)dictionary
{
    ActivityError *activityError = [[ActivityError alloc] initWithDictionary:dictionary];
    
    return activityError;
}

@end

