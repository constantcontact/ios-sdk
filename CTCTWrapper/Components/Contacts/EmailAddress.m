//
//  EmailAddress.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "EmailAddress.h"

@implementation EmailAddress

- (id)init
{
    if (self = [super init])
    {
        _emailId = @"0";
        _emailAddress = @"";
        _confirmStatus = @"";
        _status = @"";
        _optInSource = @"";
        _optInDate = nil;
        _optOutDate = nil;
    }
    
    return self;
}

- (id)initWithEmailAddress:(NSString *)emailAddress
{
    if (self = [super init])
    {
        _emailAddress = emailAddress;
    }
    
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _emailId = [Component valueForDictionary:dictionary withKey:@"id"];
        _emailAddress = [Component valueForDictionary:dictionary withKey:@"email_address"];
        _confirmStatus = [Component valueForDictionary:dictionary withKey:@"confirm_status"];
        _status = [Component valueForDictionary:dictionary withKey:@"status"];
        _optInSource = [Component valueForDictionary:dictionary withKey:@"opt_in_source"];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:sss'Z'"];
        [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        
        _optInDate = [dateFormat dateFromString:[Component valueForDictionary:dictionary withKey:@"opt_in_date"]];
        _optOutDate = [dateFormat dateFromString:[Component valueForDictionary:dictionary withKey:@"opt_out_date"]];
    }
    
    return self;
}

+ (EmailAddress *)emailAddressWithDictionary:(NSDictionary *)dictionary
{
    EmailAddress *emailAddress = [[EmailAddress alloc] initWithDictionary:dictionary];
    
    return emailAddress;
}


- (NSDictionary*)proxyForJSON
{    
    return [NSDictionary dictionaryWithObjectsAndKeys:
            _emailAddress, @"email_address",
            self.optInSource, @"opt_in_source",
            nil];
}

@end
