//
//  OptOutActivity.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "OptOutActivity.h"
#import "Component.h"



@implementation OptOutActivity

- (id)init
{
    if (self = [super init])
    {
        _activityType = @"";
        _campaignId = @"";
        _contactId = @"";
        _emailAddress = @"";
        _unsubscribeDate = @"";
        _unsubscribeSource = @"";
        _unsubscribeReason = @"";
    }
    
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _activityType = [Component valueForDictionary:dictionary withKey:@"activity_type"];
        _campaignId = [Component valueForDictionary:dictionary withKey:@"campaign_id"];
        _contactId = [Component valueForDictionary:dictionary withKey:@"contact_id"];
        _emailAddress = [Component valueForDictionary:dictionary withKey:@"email_address"];
        _unsubscribeDate = [Component valueForDictionary:dictionary withKey:@"unsubscribe_date"];
        _unsubscribeSource = [Component valueForDictionary:dictionary withKey:@"unsubscribe_source"];
        _unsubscribeReason = [Component valueForDictionary:dictionary withKey:@"unsubscribe_reason"];
    }
    return self;
}

+ (OptOutActivity *)optOutWithDictionary:(NSDictionary *)dictionary;
{
    OptOutActivity *optOutActivity = [[OptOutActivity alloc] initWithDictionary:dictionary];
    
    return optOutActivity;
}

@end
