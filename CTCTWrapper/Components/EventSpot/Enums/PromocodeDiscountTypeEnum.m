//
//  PromocodeDiscountTypeEnum.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "PromocodeDiscountTypeEnum.h"

@implementation PromocodeDiscountTypeEnum

- (id)init
{
    if (self = [super init])
    {
        _percent = @"PERCENT";
        _amount = @"AMOUNT";
    }
    return self;
}

@end
