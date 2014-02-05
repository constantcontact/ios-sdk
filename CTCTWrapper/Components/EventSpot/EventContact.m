//
//  EventContact.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "EventContact.h"

@implementation EventContact

- (id)init
{
    if (self = [super init])
    {
        _emailAddress = @"";
        _name = @"";
        _organizationName = @"";
        _phoneNumber = @"";
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _emailAddress = [Component valueForDictionary:dictionary withKey:@"email_address"];
        _name = [Component valueForDictionary:dictionary withKey:@"name"];
        _organizationName = [Component valueForDictionary:dictionary withKey:@"organization_name"];
        _phoneNumber = [Component valueForDictionary:dictionary withKey:@"phone_number"];
    }
    
    return self;
}

+ (EventContact *)eventContactWithDictionary:(NSDictionary *)dictionary
{
    EventContact *contact = [[EventContact alloc] initWithDictionary:dictionary];
    
    return contact;
}

-(NSDictionary*)proxyForJSON
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    if(_emailAddress) [dict setObject:_emailAddress forKey:@"email_address"];
    if(_name) [dict setObject:_name forKey:@"name"];
    if(_organizationName) [dict setObject:_organizationName forKey:@"organization_name"];
    if(_phoneNumber)[dict setObject:_phoneNumber forKey:@"phone_number"];
    
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
