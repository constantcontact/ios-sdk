//
//  RegistrantPaymentSummary.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "RegistrantPaymentSummary.h"

@implementation RegistrantPaymentSummary

- (id)init
{
    if (self = [super init])
    {
        _eventRegistrantPaymentTypeEnum = [[EventRegistrantPaymentTypeEnum alloc]init];
        
        _paymentType = @"";
        _paymentStatus = @"";
        
        _promocode = [[RegistrantPromoCode alloc]init];
        _order = [[RegistrantOrder alloc]init];
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _eventRegistrantPaymentTypeEnum = [[EventRegistrantPaymentTypeEnum alloc]init];
        
        _paymentType = [Component valueForDictionary:dictionary withKey:@"payment_type"];
        _paymentStatus = [Component valueForDictionary:dictionary withKey:@"payment_status"];
        
        if([dictionary objectForKey:@"promo_code"])
            _promocode = [RegistrantPromoCode registrantPromoCodeWithDictionary:[dictionary objectForKey:@"promo_code"]];
        
        if([dictionary objectForKey:@"order"])
            _order = [RegistrantOrder registrantOrderWithDictionary:[dictionary objectForKey:@"order"]];
    }
    
    return self;
}

+ (RegistrantPaymentSummary *)registrantPaymentSummartWithDictionary:(NSDictionary *)dictionary
{
    RegistrantPaymentSummary *paymentSum = [[RegistrantPaymentSummary alloc] initWithDictionary:dictionary];
    
    return paymentSum;
}

-(NSDictionary*)proxyForJSON
{
    NSError *e;
    NSDictionary *JSON = nil;
    NSString *eachElementJson;
    
    if(_promocode)
    {
        eachElementJson = [_promocode JSON];
        e = nil;
        JSON =
        [NSJSONSerialization JSONObjectWithData: [eachElementJson dataUsingEncoding:NSUTF8StringEncoding]
                                        options: NSJSONReadingMutableContainers
                                          error: &e];
    }
    NSDictionary *jsonPromo = JSON;
    JSON = nil;
    
    if(_order)
    {
        eachElementJson = [_order JSON];
        e = nil;
        JSON =
        [NSJSONSerialization JSONObjectWithData: [eachElementJson dataUsingEncoding:NSUTF8StringEncoding]
                                        options: NSJSONReadingMutableContainers
                                          error: &e];
    }
    NSDictionary *jsonOrder = JSON;
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    if(_paymentType) [dict setObject:_paymentType forKey:@"payment_type"];
    if(_paymentStatus) [dict setObject:_paymentStatus forKey:@"payment_status"];
    if(jsonPromo) [dict setObject:jsonPromo forKey:@"promo_code"];
    if(jsonOrder) [dict setObject:jsonPromo forKey:@"order"];
    
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
