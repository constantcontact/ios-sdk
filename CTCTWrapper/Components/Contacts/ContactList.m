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
        _listId = @"";
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
        _listId = [Component valueForDictionary:dictionary withKey:@"id"];
        _name = [Component valueForDictionary:dictionary withKey:@"name"];
        _status = [Component valueForDictionary:dictionary withKey:@"status"];
        _contactCount = [[Component valueForDictionary:dictionary withKey:@"contact_count"] intValue];
    }
    return self;
}

+ (ContactList *)contactListWithDictionary:(NSDictionary *)dictionary
{
    ContactList *contactList = [[ContactList alloc] initWithDictionary:dictionary];
    
    return contactList;
}

- (NSDictionary*)proxyForMinimal
{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          _listId, @"id",
                          nil];

    return dict;
}

- (NSString*)JSONForMinimal
{
    NSDictionary *jsonDict = [self proxyForMinimal];
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
- (NSDictionary*)proxyForJSON
{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          _name, @"name",
                          _status, @"status",
                          nil];
    
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
