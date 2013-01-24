//
//  ContactList.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "ContactList.h"
#import "NSObject+SBJson.h"

@implementation ContactList

- (id)init
{
    if (self = [super init])
    {
        _id = 0;
        _name = @"";
        _status = @"";
        _optInDefault = NO;
        _contactCount = 0;
    }
    
    return self;
}

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _id = [[Component valueForDictionary:dictionary withKey:@"id"]intValue];
        _name = [Component valueForDictionary:dictionary withKey:@"name"];
        _status = [Component valueForDictionary:dictionary withKey:@"status"];
        _optInDefault = [[Component valueForDictionary:dictionary withKey:@"opt_in_default"] boolValue];
        _contactCount = [[Component valueForDictionary:dictionary withKey:@"contact_count"] intValue];
    }
    return self;
}

-(id) proxyForJson
{
    return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:_id ], @"id", _name, @"name", _status, @"status", [NSNumber numberWithBool:_optInDefault], @"opt_in_default",[NSNumber numberWithInt: _contactCount], @"contact_count", nil];
}

-(NSString*) toJson
{
     return [self JSONRepresentation];
}

@end
