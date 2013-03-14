//
//  Address.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "Address.h"

@implementation Address

- (id)init
{
    if (self = [super init])
    {
        _addressType = @"";
        _city = @"";
        _countryCode = @"";
        _line1 = @"";
        _line2 = @"";
        _line3 = @"";
        _postalCode = @"";
        _stateCode = @"";
        _subPostalCode = @"";
        _stateProvince = @"";
    }
    
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _addressType = [Component valueForDictionary:dictionary withKey:@"address_type"];
        _city = [Component valueForDictionary:dictionary withKey:@"city"];
        _countryCode = [Component valueForDictionary:dictionary withKey:@"country_code"];
        _line1 = [Component valueForDictionary:dictionary withKey:@"line1"];
        _line2 = [Component valueForDictionary:dictionary withKey:@"line2"];
        _line3 = [Component valueForDictionary:dictionary withKey:@"line3"];
        _postalCode = [Component valueForDictionary:dictionary withKey:@"postal_code"];
        _stateCode = [Component valueForDictionary:dictionary withKey:@"state_code"];
        _subPostalCode = [Component valueForDictionary:dictionary withKey:@"sub_postal_code"];
        _stateProvince = [Component valueForDictionary:dictionary withKey:@"state_province"];
    }
    return self;
}

+ (Address *)addressWithDictionary:(NSDictionary *)dictionary
{
    Address *address = [[Address alloc] init];
    
    address.addressType = [Component valueForDictionary:dictionary withKey:@"address_type"];
    address.city = [Component valueForDictionary:dictionary withKey:@"city"];
    address.countryCode = [Component valueForDictionary:dictionary withKey:@"country_code"];
    address.line1 = [Component valueForDictionary:dictionary withKey:@"line1"];
    address.line2 = [Component valueForDictionary:dictionary withKey:@"line2"];
    address.line3 = [Component valueForDictionary:dictionary withKey:@"line3"];
    address.postalCode = [Component valueForDictionary:dictionary withKey:@"postal_code"];
    address.stateCode = [Component valueForDictionary:dictionary withKey:@"state_code"];
    address.subPostalCode = [Component valueForDictionary:dictionary withKey:@"sub_postal_code"];
    address.stateProvince = [Component valueForDictionary:dictionary withKey:@"state_province"];

    return address;
}

-(id) proxyForJson
{
    return [NSDictionary dictionaryWithObjectsAndKeys: _addressType, @"address_type", _city, @"city",_countryCode, @"country_code", _line1, @"line1", _line2, @"line2", _line3, @"line3", _postalCode, @"postal_code", _stateCode, @"state_code", _subPostalCode, @"sub_postal_code",_stateProvince,@"state_province", nil];
}

- (NSString *) toJson
{
    NSString *jsonDict = [self proxyForJson];
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
