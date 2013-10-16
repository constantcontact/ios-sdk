//
//  AllActivites.m
//  CTCTContact
//
//  Created by A_Dumitras on 10/15/13.
//  Copyright (c) 2013 OSF Global. All rights reserved.
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
        _unsubscribeDate = [Component valueForDictionary:dictionary withKey:@"contact_id"];
        _sendDate = [Component valueForDictionary:dictionary withKey:@"unsubscribe_date"]; 
        _forwardDate = [Component valueForDictionary:dictionary withKey:@"send_date"];
        _opens = [[Component valueForDictionary:dictionary withKey:@"forward_date"] intValue];
        _linkUri = [Component valueForDictionary:dictionary withKey:@"opens"];
        _linkId = [Component valueForDictionary:dictionary withKey:@"link_uri"];
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
    AllActivites *allActivityObject = [[AllActivites alloc] init];
    
    allActivityObject.contactId = [Component valueForDictionary:dictionary withKey:@"contact_id"];
    allActivityObject.openDate = [Component valueForDictionary:dictionary withKey:@"open_date"];
    allActivityObject.unsubscribeDate = [Component valueForDictionary:dictionary withKey:@"contact_id"];
    allActivityObject.sendDate = [Component valueForDictionary:dictionary withKey:@"unsubscribe_date"];
    allActivityObject.forwardDate = [Component valueForDictionary:dictionary withKey:@"send_date"];
    allActivityObject.opens = [[Component valueForDictionary:dictionary withKey:@"forward_date"] intValue];
    allActivityObject.linkUri = [Component valueForDictionary:dictionary withKey:@"opens"];
    allActivityObject.linkId = [Component valueForDictionary:dictionary withKey:@"link_uri"];
    allActivityObject.bounces = [[Component valueForDictionary:dictionary withKey:@"bounces"] intValue];
    allActivityObject.unsubscribeReason = [Component valueForDictionary:dictionary withKey:@"unsubscribe_reason"];
    allActivityObject.campaignId = [Component valueForDictionary:dictionary withKey:@"campaign_id"];
    allActivityObject.forwards = [[Component valueForDictionary:dictionary withKey:@"forwards"] intValue];
    allActivityObject.bounceDescription = [Component valueForDictionary:dictionary withKey:@"bounce_description"];
    allActivityObject.unsubscribeSource = [Component valueForDictionary:dictionary withKey:@"unsubscribe_source"];
    allActivityObject.bounceMessage = [Component valueForDictionary:dictionary withKey:@"bounce_message"];
    allActivityObject.bounceCode = [Component valueForDictionary:dictionary withKey:@"bounce_code"];
    allActivityObject.clicks = [[Component valueForDictionary:dictionary withKey:@"clicks"] intValue];
    allActivityObject.bounceDate = [Component valueForDictionary:dictionary withKey:@"bounce_date"];
    allActivityObject.clickDate = [Component valueForDictionary:dictionary withKey:@"click_date"];
    allActivityObject.activityType = [Component valueForDictionary:dictionary withKey:@"activity_type"];
    allActivityObject.emailAddress = [Component valueForDictionary:dictionary withKey:@"email_address"];
    
    return allActivityObject;
}
@end
