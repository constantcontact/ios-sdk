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
        _emailAddress = @"";
        _confirmStatus = @"";
        _status = @"";
        _optInSource = @"";
        _optInDate = nil;
        _optOutDate = nil;
    }
    
    return self;
}

-(id)initWithEmailAddress:(NSString *)emailAddress
{
    if (self = [super init])
    {
        _emailAddress = emailAddress;
    }
    
    return self;
}

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
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

+(EmailAddress*)addressWithDictionary:(NSDictionary *)dictionary
{
    EmailAddress *emailAddress = [[EmailAddress alloc] init];
    emailAddress.emailAddress = [Component valueForDictionary:dictionary withKey:@"email_address"];
    emailAddress.confirmStatus = [Component valueForDictionary:dictionary withKey:@"confirm_status"];
    emailAddress.status = [Component valueForDictionary:dictionary withKey:@"status"];
    emailAddress.optInSource = [Component valueForDictionary:dictionary withKey:@"opt_in_source"];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:sss'Z'"];
    [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    emailAddress.optInDate = [dateFormat dateFromString:[Component valueForDictionary:dictionary withKey:@"opt_in_date"]];
    emailAddress.optOutDate = [dateFormat dateFromString:[Component valueForDictionary:dictionary withKey:@"opt_out_date"]];
    
    return emailAddress;
}


-(id) proxyForJson
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"yyyy-MM-dd'T'HH:mm:sss'Z'"];
    
    return [NSDictionary dictionaryWithObjectsAndKeys:_emailAddress, @"email_address", _confirmStatus, @"confirm_status", _status, @"status", _optInSource , @"opt_in_source", [formatter stringFromDate:_optInDate] , @"opt_in_date", [formatter stringFromDate:_optOutDate] , @"opt_out_date", nil];
}

@end
