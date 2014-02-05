//
//  EventItemAttribute.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "EventItemAttribute.h"

@implementation EventItemAttribute

- (id)init
{
    if (self = [super init])
    {
        _itemAttributeId = @"";
        _name = @"";
        _quantityAvailable = 0;
        _quantityTotal = 0;
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _itemAttributeId = [Component valueForDictionary:dictionary withKey:@"id"];
        _name = [Component valueForDictionary:dictionary withKey:@"name"];
        _quantityAvailable = [[Component valueForDictionary:dictionary withKey:@"quantity_available"]intValue];
        _quantityTotal = [[Component valueForDictionary:dictionary withKey:@"quantity_total"] intValue];
    }
    
    return self;
}

+ (EventItemAttribute *)itemAttributeWithDictionary:(NSDictionary *)dictionary
{
    EventItemAttribute *itemAttr = [[EventItemAttribute alloc] initWithDictionary:dictionary];
    
    return itemAttr;
}

-(NSDictionary*)proxyForJSON
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    if(_name) [dict setObject:_name forKey:@"name"];
    if(_quantityTotal) [dict setObject:[NSNumber numberWithInt:_quantityTotal] forKey:@"quantity_total"];
    
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
