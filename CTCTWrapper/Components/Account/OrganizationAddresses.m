//
//  OrganizationAddresses.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "OrganizationAddresses.h"

@implementation OrganizationAddresses

- (id)init
{
    if (self = [super init])
    {
        _city = @"";
        _countryCode = @"";
        _line1 = @"";
        _line2 = @"";
        _line3 = @"";
        _postalCode = @"";
        _state = @"";
        _stateCode = @"";
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _city = [Component valueForDictionary:dictionary withKey:@"city"];
        _countryCode = [Component valueForDictionary:dictionary withKey:@"country_code"];
        _line1 = [Component valueForDictionary:dictionary withKey:@"line1"];
        _line2 = [Component valueForDictionary:dictionary withKey:@"line2"];
        _line3 = [Component valueForDictionary:dictionary withKey:@"line3"];
        _postalCode = [Component valueForDictionary:dictionary withKey:@"postal_code"];
        _state = [Component valueForDictionary:dictionary withKey:@"state"];
        _stateCode = [Component valueForDictionary:dictionary withKey:@"state_code"];
    }
    
    return self;
}

+ (OrganizationAddresses *)organizationAddressWithDictionary:(NSDictionary *)dictionary
{
    OrganizationAddresses *address = [[OrganizationAddresses alloc] initWithDictionary:dictionary];
    
    return address;
}

-(NSDictionary*)proxyForJSON
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    if(_city) [dict setObject:_city forKey:@"city"];
    if(_countryCode) [dict setObject:_countryCode forKey:@"country_code"];
    if(_line1) [dict setObject:_line1 forKey:@"line1"];
    if(_line2) [dict setObject:_line2 forKey:@"line2"];
    if(_line3) [dict setObject:_line3 forKey:@"line3"];
    if(_postalCode) [dict setObject:_postalCode forKey:@"postal_code"];
    if(_state) [dict setObject:_state forKey:@"state"];
    if(_stateCode) [dict setObject:_stateCode forKey:@"state_code"];
    
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
