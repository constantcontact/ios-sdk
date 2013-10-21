//
//  AllActivites.m
//  CTCTContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "AllActivites.h"

@implementation AllActivites

- (id)init
{
    if (self = [super init])
    {
        _contactId = @"";
        _openDate = @"";
        _unsubscribeDate = @"";
        _sendDate = @"";
        _forwardDate = @"";
        _opens = 0;
        _linkUri = @"";
        _linkId = @"";
        _bounces = 0;
        _unsubscribeReason = @"";
        _campaignId = @"";
        _forwards = 0;
        _bounceDescription = @"";
        _unsubscribeSource = @"";
        _bounceMessage = @"";
        _bounceCode = @"";
        _clicks = 0;
        _bounceDate = @"";
        _clickDate = @"";
        _activityType = @"";
        _emailAddress = @"";
    }
    
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _contactId = [Component valueForDictionary:dictionary withKey:@"contact_id"];
        _openDate = [Component valueForDictionary:dictionary withKey:@"open_date"];
        _unsubscribeDate = [Component valueForDictionary:dictionary withKey:@"unsubscribe_date"];
        _sendDate = [Component valueForDictionary:dictionary withKey:@"send_date"]; 
        _forwardDate = [Component valueForDictionary:dictionary withKey:@"forward_date"];
        _opens = [[Component valueForDictionary:dictionary withKey:@"opens"] intValue];
        _linkUri = [Component valueForDictionary:dictionary withKey:@"link_uri"];
        _linkId = [Component valueForDictionary:dictionary withKey:@"link_id"];
        _bounces = [[Component valueForDictionary:dictionary withKey:@"bounces"] intValue];
        _unsubscribeReason = [Component valueForDictionary:dictionary withKey:@"unsubscribe_reason"];
        _campaignId = [Component valueForDictionary:dictionary withKey:@"campaign_id"];
        _forwards = [[Component valueForDictionary:dictionary withKey:@"forwards"] intValue];
        _bounceDescription = [Component valueForDictionary:dictionary withKey:@"bounce_description"];
        _unsubscribeSource = [Component valueForDictionary:dictionary withKey:@"unsubscribe_source"];
        _bounceMessage = [Component valueForDictionary:dictionary withKey:@"bounce_message"];
        _bounceCode = [Component valueForDictionary:dictionary withKey:@"bounce_code"];
        _clicks = [[Component valueForDictionary:dictionary withKey:@"clicks"] intValue];
        _bounceDate = [Component valueForDictionary:dictionary withKey:@"bounce_date"];
        _clickDate = [Component valueForDictionary:dictionary withKey:@"click_date"];
        _activityType = [Component valueForDictionary:dictionary withKey:@"activity_type"];
        _emailAddress = [Component valueForDictionary:dictionary withKey:@"email_address"];
    }
    return self;
}

+ (AllActivites *)allActivitesWithDictionary:(NSDictionary *)dictionary;
{
    AllActivites *allActivityObject = [[AllActivites alloc] initWithDictionary:dictionary];
    
    return allActivityObject;
}

@end
