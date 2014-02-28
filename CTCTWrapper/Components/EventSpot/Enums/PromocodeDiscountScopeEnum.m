//
//  PromocodeDiscountScopeEnum.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "PromocodeDiscountScopeEnum.h"

@implementation PromocodeDiscountScopeEnum

- (id)init
{
    if (self = [super init])
    {
        _feeList = @"FEE_LIST";
        
        _orderTotal = @"ORDER_TOTAL";
    }
    return self;
}

@end
