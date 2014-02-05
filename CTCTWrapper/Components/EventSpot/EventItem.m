//
//  EventItem.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "EventItem.h"

@implementation EventItem

- (id)init
{
    if (self = [super init])
    {
        _attributes = [[NSMutableArray alloc] init];
        _defaultQuantityAvailable = 0;
        _defaultQuantityTotal = 0;
        _description = @"";
        _eventItemId = @"";
        _name = @"";
        _perRegistrantLimit = 0;
        _price = 0;
        _showQuantityAvailable = false;
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _defaultQuantityAvailable = [[Component valueForDictionary:dictionary withKey:@"default_quantity_available"] intValue];
        _defaultQuantityTotal = [[Component valueForDictionary:dictionary withKey:@"default_quantity_total"] intValue];
        _description = [Component valueForDictionary:dictionary withKey:@"description"];
        _eventItemId = [Component valueForDictionary:dictionary withKey:@"id"];
        _name = [Component valueForDictionary:dictionary withKey:@"name"];
        _perRegistrantLimit = [[Component valueForDictionary:dictionary withKey:@"per_registrant_limit"] intValue];
        _price = [[Component valueForDictionary:dictionary withKey:@"price"] doubleValue];
        _showQuantityAvailable = [[Component valueForDictionary:dictionary withKey:@"show_quantity_available"] boolValue];
        
        _attributes = [[NSMutableArray alloc]init];
        
        if([dictionary objectForKey:@"attributes"])
            for(NSDictionary *attribute in [dictionary objectForKey:@"attributes"])
            {
                [_attributes addObject:[EventItemAttribute itemAttributeWithDictionary:attribute]];
            }
    }
    
    return self;
}

+ (EventItem *)eventItemWithDictionary:(NSDictionary *)dictionary
{
    EventItem *itemAttr = [[EventItem alloc] initWithDictionary:dictionary];
    
    return itemAttr;
}

-(NSDictionary*)proxyForJSON
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    if(_defaultQuantityTotal)[dict setObject:[NSNumber numberWithInt:_defaultQuantityTotal] forKey:@"default_quantity_total"];
     if(_description)[dict setObject:_description forKey:@"description"];
     if(_name)[dict setObject:_name forKey:@"name"];
     if(_perRegistrantLimit)[dict setObject:[NSNumber numberWithInt:_perRegistrantLimit] forKey:@"per_registrant_limit"];
     if(_price)[dict setObject:[NSNumber numberWithDouble:_price] forKey:@"price"];
     if([NSNumber numberWithBool:_showQuantityAvailable] != nil)[dict setObject:[NSNumber numberWithBool:_showQuantityAvailable] forKey:@"show_quantity_available"];
    
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
