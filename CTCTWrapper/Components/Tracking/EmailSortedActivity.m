//
//  EmailSortedActivity.m
//  CTCTContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "EmailSortedActivity.h"

@implementation EmailSortedActivity

- (id)init
{
    if (self = [super init])
    {
       _contactId = @"";
       _clicks = 0;
       _opens = 0;
       _bounces = 0;
       _forwards = 0;
       _campaignId = @"";
    }
    
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _contactId  = [Component valueForDictionary:dictionary withKey:@"contact_id"];
        _clicks     = [[Component valueForDictionary:dictionary withKey:@"clicks"] intValue];
        _opens      = [[Component valueForDictionary:dictionary withKey:@"opens"] intValue];
        _bounces    = [[Component valueForDictionary:dictionary withKey:@"bounces"] intValue];
        _forwards   = [[Component valueForDictionary:dictionary withKey:@"forwards"] intValue];
        _campaignId = [Component valueForDictionary:dictionary withKey:@"campaign_id"];
    }
    return self;
}

+ (EmailSortedActivity *)emailSortedActivityWithDictionary:(NSDictionary *)dictionary;
{
    EmailSortedActivity *emailSortedActivity = [[EmailSortedActivity alloc] initWithDictionary:dictionary];
    
    return emailSortedActivity;
}

@end
