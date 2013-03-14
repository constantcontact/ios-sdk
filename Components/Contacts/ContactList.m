//
//  ContactList.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "ContactList.h"

@implementation ContactList

- (id)init
{
    if (self = [super init])
    {
        _id = @"";
        _name = @"";
        _status = @"";
        _contactCount = 0;
    }
    
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _id = [Component valueForDictionary:dictionary withKey:@"id"];
        _name = [Component valueForDictionary:dictionary withKey:@"name"];
        _status = [Component valueForDictionary:dictionary withKey:@"status"];
        _contactCount = [[Component valueForDictionary:dictionary withKey:@"contact_count"] intValue];
    }
    return self;
}

+ (ContactList *)contactListWithDictionary:(NSDictionary *)dictionary
{
    ContactList *contactList = [[ContactList alloc] init];
    
    contactList.id = [Component valueForDictionary:dictionary withKey:@"id"];
    contactList.name = [Component valueForDictionary:dictionary withKey:@"name"];
    contactList.status = [Component valueForDictionary:dictionary withKey:@"status"];
    contactList.contactCount = [[Component valueForDictionary:dictionary withKey:@"contact_count"] intValue];
    
    return contactList;
}

- (id) proxyForJson
{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:_id, @"id",nil];// _name, @"name", _status, @"status", [NSNumber numberWithInt: _contactCount], @"contact_count", nil];

    return dict;
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
- (id) proxyForJsonLists
{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:_id, @"id", _name, @"name", _status, @"status", [NSNumber numberWithInt: _contactCount], @"contact_count", nil];
    
    return dict;
}

- (NSString *) toJsonCampaigns
{
    NSString *jsonDict = [self proxyForJsonLists];
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
