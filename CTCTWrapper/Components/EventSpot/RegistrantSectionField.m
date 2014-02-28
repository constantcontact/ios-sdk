//
//  RegistrantSectionField.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "RegistrantSectionField.h"

@implementation RegistrantSectionField

- (id)init
{
    if (self = [super init])
    {
        _type = @"";
        _name = @"";
        _label = @"";
        _value = @"";
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _type = [Component valueForDictionary:dictionary withKey:@"type"];;
        _name = [Component valueForDictionary:dictionary withKey:@"name"];;
        _label = [Component valueForDictionary:dictionary withKey:@"label"];;
        _value = [Component valueForDictionary:dictionary withKey:@"value"];;
    }
    
    return self;
}

+ (RegistrantSectionField *)sectionFieldWithDictionary:(NSDictionary *)dictionary
{
    RegistrantSectionField *field = [[RegistrantSectionField alloc] initWithDictionary:dictionary];
    
    return field;
}

-(NSDictionary*)proxyForJSON
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    if(_type)[dict setObject:_type forKey:@"type"];
    if(_name)[dict setObject:_name forKey:@"name"];
    if(_label)[dict setObject:_label forKey:@"label"];
    if(_value)[dict setObject:_value forKey:@"value"];
    
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
