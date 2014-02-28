//
//  RegistrantGuest.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "RegistrantGuest.h"

@implementation RegistrantGuest

- (id)init
{
    if (self = [super init])
    {
        _guestCount = 0;
        _guestsInfo = [[NSMutableArray alloc]init];
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _guestCount = [[Component valueForDictionary:dictionary withKey:@"guest_count"] integerValue];
  
        _guestsInfo = [[NSMutableArray alloc]init];
        if([dictionary objectForKey:@"guest_info"])
        for(NSDictionary *info in [dictionary objectForKey:@"guest_info"])
        {
            [_guestsInfo addObject:[RegistrantGuestInfo registrantGuestInfoWithDictionary:info]];
        }
    }
    return self;
}

+ (RegistrantGuest *)registrantGuestWithDictionary:(NSDictionary *)dictionary
{
    RegistrantGuest *guestSection = [[RegistrantGuest alloc] initWithDictionary:dictionary];
    
    return guestSection;
}

-(NSDictionary*)proxyForJSON
{
    NSMutableArray *jsonNotifArray = [[NSMutableArray alloc]init];
    if(_guestsInfo.count > 0)
    {
        for(RegistrantGuestInfo *info in _guestsInfo)
        {
            NSString *eachElementJson = [info JSON];
            NSError *e = nil;
            NSDictionary *JSON =
            [NSJSONSerialization JSONObjectWithData: [eachElementJson dataUsingEncoding:NSUTF8StringEncoding]
                                            options: NSJSONReadingMutableContainers
                                              error: &e];
            
            [jsonNotifArray addObject:JSON];
        }
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    if (_guestCount) [dict setObject:[NSNumber numberWithInt:_guestCount] forKey:@"guest_count"];
    if (jsonNotifArray.count > 0) [dict setObject:jsonNotifArray forKey:@"guest_info"];
    
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
