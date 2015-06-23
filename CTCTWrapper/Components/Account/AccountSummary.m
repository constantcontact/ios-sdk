//
//  AccountSummary.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "AccountSummary.h"

@implementation AccountSummary

- (id)init
{
    if (self = [super init])
    {
        _countryCode = @"";
        _email = @"";
        _firstName = @"";
        _lastName = @"";
        _organizationAddresses = [[NSMutableArray alloc]init];
        _organizationName = @"";
        _phone = @"";
        _stateCode = @"";
        _timeZone = @"";
        _website = @"";
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
		_companyLogo = [Component valueForDictionary:dictionary withKey:@"company_logo"];
        _countryCode = [Component valueForDictionary:dictionary withKey:@"country_code"];
        _email = [Component valueForDictionary:dictionary withKey:@"email"];
        _firstName = [Component valueForDictionary:dictionary withKey:@"first_name"];
        _lastName = [Component valueForDictionary:dictionary withKey:@"last_name"];
        _organizationName = [Component valueForDictionary:dictionary withKey:@"organization_name"];
        _phone = [Component valueForDictionary:dictionary withKey:@"phone"];
        _stateCode = [Component valueForDictionary:dictionary withKey:@"state_code"];
        _timeZone = [Component valueForDictionary:dictionary withKey:@"time_zone"];
        _website = [Component valueForDictionary:dictionary withKey:@"website"];
        
        _organizationAddresses = [[NSMutableArray alloc]init];
        
        if([dictionary objectForKey:@"organization_addresses"])
            for(NSDictionary *address in [dictionary objectForKey:@"organization_addresses"])
            {
                [_organizationAddresses addObject:[OrganizationAddresses organizationAddressWithDictionary:address]];
            }
    }
    
    return self;
}

+ (AccountSummary *)accountSummaryWithDictionary:(NSDictionary *)dictionary
{
    AccountSummary *summary = [[AccountSummary alloc] initWithDictionary:dictionary];
    
    return summary;
}

-(NSDictionary*)proxyForJSON
{
    NSMutableArray *jsonAddressArray = [[NSMutableArray alloc]init];
    if(_organizationAddresses.count > 0)
    {
        for(OrganizationAddresses *addr in _organizationAddresses)
        {
            NSString *eachElementJson = [addr JSON];
            NSError *e = nil;
            NSDictionary *JSON =
            [NSJSONSerialization JSONObjectWithData: [eachElementJson dataUsingEncoding:NSUTF8StringEncoding]
                                            options: NSJSONReadingMutableContainers
                                              error: &e];
            
            [jsonAddressArray addObject:JSON];
        }
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
	
    if (_countryCode)[dict setObject:_countryCode forKey:@"country_code"];
    if (_email)[dict setObject:_email forKey:@"email"];
    if (_firstName)[dict setObject:_firstName forKey:@"first_name"];
    if (_lastName)[dict setObject:_lastName forKey:@"last_name"];
    if (_organizationName)[dict setObject:_organizationName forKey:@"organization_name"];
    if (_phone)[dict setObject:_phone forKey:@"phone"];
    if (_stateCode)[dict setObject:_stateCode forKey:@"state_code"];
    if (_website)[dict setObject:_website forKey:@"website"];
    if (jsonAddressArray.count > 0) [dict setObject:jsonAddressArray forKey:@"organization_addresses"];
	if (_companyLogo) dict[@"company_logo"] = _companyLogo;
    
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
