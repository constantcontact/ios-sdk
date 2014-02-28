//
//  RegistrantOrder.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "RegistrantOrder.h"

@implementation RegistrantOrder

- (id)init
{
    if (self = [super init])
    {
        _total = 0;
        _currencyType = @"";
        _orderDate = @"";
        _orderId = @"";
        _fees = [[NSMutableArray alloc]init];
        _items = [[NSMutableArray alloc]init];
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _total = [[Component valueForDictionary:dictionary withKey:@"total"] doubleValue];
        _currencyType = [Component valueForDictionary:dictionary withKey:@"currency_type"];
        _orderDate = [Component valueForDictionary:dictionary withKey:@"order_date"];
        _orderId = [Component valueForDictionary:dictionary withKey:@"order_id"];
        
        _fees = [[NSMutableArray alloc]init];
        if([dictionary objectForKey:@"fees"])
            for(NSDictionary *fee in [dictionary objectForKey:@"fees"])
            {
                [_fees addObject:[RegistrantFee registrantFeeWithDictionary:fee]];
            }

        _items = [[NSMutableArray alloc]init];
        if([dictionary objectForKey:@"items"])
            for(NSDictionary *item in [dictionary objectForKey:@"items"])
            {
                [_items addObject:[RegistrantSaleItem saleItemWithDictionary:item]];
            }
    }
    
    return self;
}

+ (RegistrantOrder *)registrantOrderWithDictionary:(NSDictionary *)dictionary
{
    RegistrantOrder *registrantOrder = [[RegistrantOrder alloc] initWithDictionary:dictionary];
    
    return registrantOrder;
}

-(NSDictionary*)proxyForJSON
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    if (_total) [dict setObject:[NSNumber numberWithDouble:_total] forKey:@"total"];
    if (_currencyType) [dict setObject:_currencyType forKey:@"currency_type"];
    if (_orderDate) [dict setObject:_orderDate forKey:@"order_date"];
    if (_orderId) [dict setObject:_orderId forKey:@"order_id"];
    
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

