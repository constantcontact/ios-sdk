//
//  BounceActivity.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "BounceActivity.h"

@implementation BounceActivity

- (id)init
{
    if (self = [super init])
    {
        _activityType = @"";
        _bounceCode = @"";
        _bounceDescription = @"";
        _bounceMessage = @"";
        _bounceDate = @"";
        _contactId = @"";
        _emailAddress = @"";
        _campaignId = @"";
    }
    
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _activityType = [Component valueForDictionary:dictionary withKey:@"activity_type"];
        _bounceCode = [Component valueForDictionary:dictionary withKey:@"bounce_code"];
        _bounceDescription = [Component valueForDictionary:dictionary withKey:@"bounce_description"];
        _bounceMessage = [Component valueForDictionary:dictionary withKey:@"bounce_message"];
        _bounceDate = [Component valueForDictionary:dictionary withKey:@"bounce_date"];
        _contactId = [Component valueForDictionary:dictionary withKey:@"contact_id"];
        _emailAddress = [Component valueForDictionary:dictionary withKey:@"email_address"];
        _campaignId = [Component valueForDictionary:dictionary withKey:@"campaign_id"];
    }
    return self;
}

+ (BounceActivity *)bounceActivityWithDictionary:(NSDictionary *)dictionary
{
    BounceActivity *bounceActivity = [[BounceActivity alloc] init];
    
    bounceActivity.activityType = [Component valueForDictionary:dictionary withKey:@"activity_type"];
    bounceActivity.bounceCode = [Component valueForDictionary:dictionary withKey:@"bounce_code"];
    bounceActivity.bounceDescription = [Component valueForDictionary:dictionary withKey:@"bounce_description"];
    bounceActivity.bounceMessage = [Component valueForDictionary:dictionary withKey:@"bounce_message"];
    bounceActivity.bounceDate = [Component valueForDictionary:dictionary withKey:@"bounce_date"];
    bounceActivity.contactId = [Component valueForDictionary:dictionary withKey:@"contact_id"];
    bounceActivity.emailAddress = [Component valueForDictionary:dictionary withKey:@"email_address"];
    bounceActivity.campaignId = [Component valueForDictionary:dictionary withKey:@"campaign_id"];

    return bounceActivity;
}

@end
