//
//  RegistrantFee.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "RegistrantFee.h"

@implementation RegistrantFee

- (id)init
{
    if (self = [super init])
    {
        _amount = 0;
        _feeId = @"";
        _promoType = 0;
        _name = @"";
        _quantity = 0;
        _type = @"";
        _feePeriodType = @"";
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _amount = [[Component valueForDictionary:dictionary withKey:@"amount"] floatValue];
        _feeId = [Component valueForDictionary:dictionary withKey:@"id"];
        _promoType = [[Component valueForDictionary:dictionary withKey:@"promo_type"] floatValue];
        _name = [Component valueForDictionary:dictionary withKey:@"name"];
        _quantity = [[Component valueForDictionary:dictionary withKey:@"quantity"] intValue];
        _type = [Component valueForDictionary:dictionary withKey:@"type"];
        _feePeriodType = [Component valueForDictionary:dictionary withKey:@"fee_period_type"];
    }
    
    return self;
}

+ (RegistrantFee *)registrantFeeWithDictionary:(NSDictionary *)dictionary
{
    RegistrantFee *fee = [[RegistrantFee alloc] initWithDictionary:dictionary];
    
    return fee;
}

-(NSDictionary*)proxyForJSON
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    if(_amount) [dict setObject:[NSNumber numberWithFloat:_amount] forKey:@"amount"];
    if(_feeId) [dict setObject:_feeId forKey:@"id"];
    if(_promoType) [dict setObject:[NSNumber numberWithFloat:_promoType] forKey:@"promo_type"];
    if(_name) [dict setObject:_name forKey:@"name"];
    if(_quantity) [dict setObject:[NSNumber numberWithInt:_quantity] forKey:@"quantity"];
    if(_type) [dict setObject:_type forKey:@"type"];
    if(_feePeriodType) [dict setObject:_feePeriodType forKey:@"fee_period_type"];
    
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
