//
//  ClickActivity.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "ClickActivity.h"

@implementation ClickActivity

- (id)init
{
    if (self = [super init])
    {
        _activityType = @"";
        _contactId = @"";
        _emailAddress = @"";
        _linkId = @"";
        _clickDate = @"";
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
        _linkId = [Component valueForDictionary:dictionary withKey:@"link_id"];
        _clickDate = [Component valueForDictionary:dictionary withKey:@"click_date"];
        _campaignId = [Component valueForDictionary:dictionary withKey:@"campaign_id"];
    }
    return self;
}

+ (ClickActivity *)clickActivityWithDictionary:(NSDictionary *)dictionary
{
    ClickActivity *clickActivity = [[ClickActivity alloc] initWithDictionary:dictionary];
    
    return clickActivity;
}

@end
