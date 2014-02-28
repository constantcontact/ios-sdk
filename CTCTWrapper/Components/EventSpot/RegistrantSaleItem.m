//
//  RegistrantSaleItem.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "RegistrantSaleItem.h"

@implementation RegistrantSaleItem

- (id)init
{
    if (self = [super init])
    {
        _amount = 0;
        _saleItemId = @"";
        _promoType = 0;
        _name = @"";
        _quantity = 0;
        _type = @"";
        _feePeriodType = 0;
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _amount = [[Component valueForDictionary:dictionary withKey:@"amount"] floatValue];
        _saleItemId = [Component valueForDictionary:dictionary withKey:@"id"];
        _promoType = [[Component valueForDictionary:dictionary withKey:@"promo_type"] floatValue];
        _name = [Component valueForDictionary:dictionary withKey:@"name"];
        _quantity = [[Component valueForDictionary:dictionary withKey:@"quantity"] integerValue];
        _type = [Component valueForDictionary:dictionary withKey:@"type"];
        _feePeriodType = [[Component valueForDictionary:dictionary withKey:@"fee_period_type"] floatValue];
    }
    
    return self;
}

+ (RegistrantSaleItem *)saleItemWithDictionary:(NSDictionary *)dictionary
{
    RegistrantSaleItem *saleItem = [[RegistrantSaleItem alloc] initWithDictionary:dictionary];
    
    return saleItem;
}

@end
