//
//  ForwardActivity.m
//  ConstantContact
//
//  Copyright (c) 2013 ConstantContact. All rights reserved.
//

#import "ForwardActivity.h"

@implementation ForwardActivity

- (id)init
{
    if (self = [super init])
    {
        _activityType = @"";
        _contactId = @"";
        _emailAddress = @"";
        _forwardDate = @"";
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
        _forwardDate = [Component valueForDictionary:dictionary withKey:@"forward_date"];
        _campaignId = [Component valueForDictionary:dictionary withKey:@"campaign_id"];
    }
    return self;
}

+ (ForwardActivity *)forwardActivityWithDictionary:(NSDictionary *)dictionary;
{
    ForwardActivity *forwardActivity = [[ForwardActivity alloc] init];
    
    forwardActivity.activityType = [Component valueForDictionary:dictionary withKey:@"activity_type"];
    forwardActivity.contactId = [Component valueForDictionary:dictionary withKey:@"contact_id"];
    forwardActivity.emailAddress = [Component valueForDictionary:dictionary withKey:@"email_address"];
    forwardActivity.forwardDate = [Component valueForDictionary:dictionary withKey:@"forward_date"];
    forwardActivity.campaignId = [Component valueForDictionary:dictionary withKey:@"campaign_id"];
    return forwardActivity;
}

@end
