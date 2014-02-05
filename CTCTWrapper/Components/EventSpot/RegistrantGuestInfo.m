//
//  RegistrantGuestInfo.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "RegistrantGuestInfo.h"

@implementation RegistrantGuestInfo

- (id)init
{
    if (self = [super init])
    {
        _guestId = @"";
        _guestSections = [[RegistrantGuestSections alloc]init];
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _guestId = [Component valueForDictionary:dictionary withKey:@"guest_id"];

        _guestSections = [[NSMutableArray alloc] init];
        
        if([dictionary objectForKey:@"guest_section"])
            _guestSections =[RegistrantGuestSections registrantGuestSectionsWithDictionary:[dictionary objectForKey:@"guest_section"]];

    }
    
    return self;
}

+ (RegistrantGuestInfo *)registrantGuestInfoWithDictionary:(NSDictionary *)dictionary
{
    RegistrantGuestInfo *guestInfo = [[RegistrantGuestInfo alloc] initWithDictionary:dictionary];
    
    return guestInfo;
}

-(NSDictionary*)proxyForJSON
{
    NSError *e;
    NSDictionary *JSON = nil;
    NSString *eachElementJson;
    
    if(_guestSections)
    {
        eachElementJson = [_guestSections JSON];
        e = nil;
        JSON =
        [NSJSONSerialization JSONObjectWithData: [eachElementJson dataUsingEncoding:NSUTF8StringEncoding]
                                        options: NSJSONReadingMutableContainers
                                          error: &e];
    }
    NSDictionary *jsonSection = JSON;
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    if (_guestId) [dict setObject:_guestId forKey:@"guest_id"];
    if (jsonSection) [dict setObject:jsonSection forKey:@"guest_section"];
    
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
