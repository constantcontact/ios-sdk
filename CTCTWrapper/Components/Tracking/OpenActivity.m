//
//  OpenActivity.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "OpenActivity.h"

@implementation OpenActivity

- (id)init
{
    if (self = [super init])
    {
        _activityType = @"";
        _contactId = @"";
        _emailAddress = @"";
        _openDate = @"";
        _campaignId = @"";
    }
    
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _activityType = [Component valueForDictionary:dictionary withKey:@"activity_type"];
        _contactId = [Component valueForDictionary:dictionary withKey:@"contact_id"];
        _emailAddress = [Component valueForDictionary:dictionary withKey:@"email_address"];
        _openDate = [Component valueForDictionary:dictionary withKey:@"open_date"];
        _campaignId = [Component valueForDictionary:dictionary withKey:@"campaign_id"];
    }
    return self;
}

+ (OpenActivity *)openActivityWithDictionary:(NSDictionary *)dictionary
{
    OpenActivity *openActivity = [[OpenActivity alloc] initWithDictionary:dictionary];
    
    return openActivity;
}

@end
