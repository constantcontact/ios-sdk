//
//  RegistrantSection.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "RegistrantSection.h"

@implementation RegistrantSection

- (id)init
{
    if (self = [super init])
    {
        _eventRegistrantSectionsFieldTypeEnum = [[EventRegistrantSectionsFieldTypeEnum alloc]init];
        
       _fieldType = @"";
       _values = [[NSMutableArray alloc]init];
       _name = @"";
       _value = @"";
       _label = @"";
       _fields = [[NSMutableArray alloc] init];
        
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
         _eventRegistrantSectionsFieldTypeEnum = [[EventRegistrantSectionsFieldTypeEnum alloc]init];
        
        _fieldType = [Component valueForDictionary:dictionary withKey:@"field_type"];
        _name = [Component valueForDictionary:dictionary withKey:@"name"];
        _value = [Component valueForDictionary:dictionary withKey:@"value"];
        _label = [Component valueForDictionary:dictionary withKey:@"label"];
        
        _values = [[NSMutableArray alloc] init];
        
        if([dictionary objectForKey:@"values"])
        for(NSString *idString in [dictionary objectForKey:@"values"])
        {
            [_values addObject:idString];
        }
        
        _fields = [[NSMutableArray alloc] init];
        
        if([dictionary objectForKey:@"fields"])
        for(NSDictionary *fieldDict in [dictionary objectForKey:@"fields"])
        {
            [_fields addObject:[RegistrantSectionField sectionFieldWithDictionary:fieldDict]];
        }
    }
    
    return self;
}

+ (RegistrantSection *)registrantSectionWithDictionary:(NSDictionary *)dictionary
{
    RegistrantSection *registrantSection = [[RegistrantSection alloc] initWithDictionary:dictionary];
    
    return registrantSection;
}

-(NSDictionary*)proxyForJSON
{
    NSMutableArray *jsonFieldArray = [[NSMutableArray alloc]init];
    if(_fields.count > 0)
    {
        for(RegistrantSectionField *field in _fields)
        {
            NSString *eachElementJson = [field JSON];
            NSError *e = nil;
            NSDictionary *JSON =
            [NSJSONSerialization JSONObjectWithData: [eachElementJson dataUsingEncoding:NSUTF8StringEncoding]
                                            options: NSJSONReadingMutableContainers
                                              error: &e];
            
            [jsonFieldArray addObject:JSON];
        }
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    if(_fieldType) [dict setObject:_fieldType forKey:@"field_type"];
    if(_name) [dict setObject:_name forKey:@"name"];
    if(_value) [dict setObject:_value forKey:@"value"];
    if(_label) [dict setObject:_label forKey:@"label"];
    if(_values) [dict setObject:_values forKey:@"values"];
    if(jsonFieldArray > 0) [dict setObject:jsonFieldArray forKey:@"fields"];
    
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
