//
//  CustomField.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "CustomField.h"

@implementation CustomField

- (id)init
{
    if (self = [super init])
    {
        _name = @"";
        _value = @"";
    }
    
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _name = [dictionary objectForKey:@"name"];
        _value = [dictionary objectForKey:@"value"];
    }
    
    return self;
}

+ (CustomField*)customFieldWithDictionary:(NSDictionary *)dictionary
{
    CustomField *customField = [[CustomField alloc] initWithDictionary:dictionary];
    
    return customField;
}

- (NSDictionary*)proxyForJSON
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            _name, @"name",
            _value, @"value",
            nil];
}

@end
