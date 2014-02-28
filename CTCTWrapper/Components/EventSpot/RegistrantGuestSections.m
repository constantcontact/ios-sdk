//
//  RegistrantGuestSections.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "RegistrantGuestSections.h"

@implementation RegistrantGuestSections

- (id)init
{
    if (self = [super init])
    {
        _label = @"";
        _sectionFields = [[NSMutableArray alloc]init];

    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _label = [Component valueForDictionary:dictionary withKey:@"label"];
        
        
        _sectionFields = [[NSMutableArray alloc] init];
        
        if([dictionary objectForKey:@"fields"])
            for(NSDictionary *fieldDict in [dictionary objectForKey:@"fields"])
            {
                [_sectionFields addObject:[RegistrantSectionField sectionFieldWithDictionary:fieldDict]];
            }
       
    }
    return self;
}

+ (RegistrantGuestSections *)registrantGuestSectionsWithDictionary:(NSDictionary *)dictionary
{
    RegistrantGuestSections *sect = [[RegistrantGuestSections alloc] initWithDictionary:dictionary];
    
    return sect;
}

-(NSDictionary*)proxyForJSON
{
    NSMutableArray *jsonFieldArray = [[NSMutableArray alloc]init];
    if(_sectionFields.count > 0)
    {
        for(RegistrantSectionField *field in _sectionFields)
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
    
    if(_label)[dict setObject:_label forKey:@"label"];
    if(jsonFieldArray.count > 0)[dict setObject:_sectionFields forKey:@"fields"];

    
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
