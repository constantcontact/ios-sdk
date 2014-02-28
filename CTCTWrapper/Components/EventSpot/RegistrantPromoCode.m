//
//  RegistrantPromoCode.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "RegistrantPromoCode.h"

@implementation RegistrantPromoCode

- (id)init
{
    if (self = [super init])
    {
        _totalDiscount = 0;
        _promocodeInfo = [[RegistrantPromocodeInfo alloc]init];
        
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _totalDiscount = [[Component valueForDictionary:dictionary withKey:@"total_discount"] doubleValue];
        
        if([dictionary objectForKey:@"promo_code_info"])
            _promocodeInfo =[RegistrantPromocodeInfo promocodeInfoWithDictionary:[dictionary objectForKey:@"promo_code_info"]];
    }
    return self;
}

+ (RegistrantPromoCode *)registrantPromoCodeWithDictionary:(NSDictionary *)dictionary
{
    RegistrantPromoCode *prom = [[RegistrantPromoCode alloc] initWithDictionary:dictionary];
    
    return prom;
}

-(NSDictionary*)proxyForJSON
{
    NSError *e;
    NSDictionary *JSON = nil;
    NSString *eachElementJson;
    
    if(_promocodeInfo)
    {
        eachElementJson = [_promocodeInfo JSON];
        e = nil;
        JSON =
        [NSJSONSerialization JSONObjectWithData: [eachElementJson dataUsingEncoding:NSUTF8StringEncoding]
                                        options: NSJSONReadingMutableContainers
                                          error: &e];
    }
    NSDictionary *jsonPromo = JSON;
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    if(_totalDiscount)[dict setObject:[NSNumber numberWithDouble:_totalDiscount] forKey:@"total_discount"];
    if(jsonPromo)[dict setObject:jsonPromo forKey:@"promo_code_info"];
    
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

