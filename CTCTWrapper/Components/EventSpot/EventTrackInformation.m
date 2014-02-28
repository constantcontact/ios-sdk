//
//  EventTrackInformation.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "EventTrackInformation.h"

@implementation EventTrackInformation

- (id)init
{
    if (self = [super init])
    {
        _informationSectionsEnum = [[EventInformationSectionsEnum alloc]init];
        
        _earlyFeeDate = @"";
        _guestDisplayLabel = @"";
        _guestLimit = 0;
        _informationSections = [[NSMutableArray alloc]init];
        _isGuestAnonymusEnabled = false;
        _isGuestNameRequired = false;
        _isRegistrationClosedManually = false;
        _isTicketingLinkDisabled = false;
        _lateFeeDate = @"";
        _registrationLimitCount = 0;
        _registrationLimitDate = @"";
        
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _informationSectionsEnum = [[EventInformationSectionsEnum alloc]init];
        
        _earlyFeeDate = [Component valueForDictionary:dictionary withKey:@"early_fee_date"];
        _guestDisplayLabel = [Component valueForDictionary:dictionary withKey:@"guest_display_label"];
        _guestLimit = [[Component valueForDictionary:dictionary withKey:@"guest_limit"] intValue];
    
        _isGuestAnonymusEnabled = [[Component valueForDictionary:dictionary withKey:@"is_guest_anonymous_enabled"] boolValue];
        _isGuestNameRequired = [[Component valueForDictionary:dictionary withKey:@"is_guest_name_required"] boolValue];
        _isRegistrationClosedManually = [[Component valueForDictionary:dictionary withKey:@"is_registration_closed_manually"] boolValue];
        _isTicketingLinkDisabled = [[Component valueForDictionary:dictionary withKey:@"is_ticketing_link_displayed"] boolValue];
        _lateFeeDate = [Component valueForDictionary:dictionary withKey:@"late_fee_date"];
        _registrationLimitCount = [[Component valueForDictionary:dictionary withKey:@"registration_limit_count"] intValue];
        _registrationLimitDate = [Component valueForDictionary:dictionary withKey:@"registration_limit_date"];
        
        _informationSections = [[NSMutableArray alloc]init];
        if([dictionary objectForKey:@"information_sections"])
        {
            for (NSString *infoValue in [dictionary objectForKey:@"information_sections"])
            {
                [_informationSections addObject:infoValue];
            }
        }
    }
    
    return self;
}

+ (EventTrackInformation *)eventTrackInfoWithDictionary:(NSDictionary *)dictionary
{
    EventTrackInformation *info = [[EventTrackInformation alloc] initWithDictionary:dictionary];
    
    return info;
}

-(NSDictionary*)proxyForJSON
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    if(_earlyFeeDate)[dict setObject:_earlyFeeDate forKey:@"early_fee_date"];
    if(_guestDisplayLabel)[dict setObject:_guestDisplayLabel forKey:@"guest_display_label"];
    if(_guestLimit)[dict setObject:[NSNumber numberWithInt:_guestLimit] forKey:@"guest_limit"];
    if(_informationSections.count > 0)[dict setObject:_informationSections forKey:@"information_sections"];
    if([NSNumber numberWithBool:_isGuestAnonymusEnabled] != nil)[dict setObject: [NSNumber numberWithBool:_isGuestAnonymusEnabled] forKey:@"is_guest_anonymous_enabled"];
    if([NSNumber numberWithBool:_isGuestNameRequired] != nil)[dict setObject:[NSNumber numberWithBool:_isGuestNameRequired] forKey:@"is_guest_name_required"];
    if([NSNumber numberWithBool:_isRegistrationClosedManually] != nil)[dict setObject:[NSNumber numberWithBool:_isRegistrationClosedManually] forKey:@"is_registration_closed_manually"];
    if([NSNumber numberWithBool:_isTicketingLinkDisabled] != nil)[dict setObject:[NSNumber numberWithBool:_isTicketingLinkDisabled]  forKey:@"is_ticketing_link_displayed"];
    if(_lateFeeDate)[dict setObject:_lateFeeDate forKey:@"late_fee_date"];
    if(_registrationLimitCount)[dict setObject:[NSNumber numberWithInt:_registrationLimitCount] forKey:@"registration_limit_count"];
    if(_registrationLimitDate)[dict setObject:_registrationLimitDate forKey:@"registration_limit_date"];
    
    return dict;
}

- (NSString*)JSON
{
    NSDictionary *jsonDict = [self proxyForJSON];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *jsonString = @"";
    
    if (!jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    return jsonString;
}

@end
