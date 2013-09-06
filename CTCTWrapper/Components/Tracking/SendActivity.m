//
//  SendActivity.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "SendActivity.h"

@implementation SendActivity

- (id)init
{
    if (self = [super init])
    {
        _activityType = @"";
        _sendDate = @"";
        _contactId = @"";
        _emailAddress = @"";
        _campaignId = @"";
    }
    
    return self;
}

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _activityType = [Component valueForDictionary:dictionary withKey:@"activity_type"];
        _sendDate = [Component valueForDictionary:dictionary withKey:@"send_date"];
        _contactId = [Component valueForDictionary:dictionary withKey:@"contact_id"];
        _emailAddress = [Component valueForDictionary:dictionary withKey:@"email_address"];
        _campaignId = [Component valueForDictionary:dictionary withKey:@"campaign_id"];
    }
    return self;
}

+ (SendActivity *)sendActivityWithDictionary:(NSDictionary *)dictionary;
{
    SendActivity *sendActivity = [[SendActivity alloc]init];
    
    sendActivity.activityType = [Component valueForDictionary:dictionary withKey:@"activity_type"];
    sendActivity.sendDate = [Component valueForDictionary:dictionary withKey:@"send_date"];
    sendActivity.contactId = [Component valueForDictionary:dictionary withKey:@"contact_id"];
    sendActivity.emailAddress = [Component valueForDictionary:dictionary withKey:@"email_address"];
    sendActivity.campaignId = [Component valueForDictionary:dictionary withKey:@"campaign_id"];
    
    return sendActivity;
}

@end
