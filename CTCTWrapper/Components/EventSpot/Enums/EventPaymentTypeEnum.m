//
//  EventPaymentTypeEnum.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "EventPaymentTypeEnum.h"

@implementation EventPaymentTypeEnum

- (id)init
{
    if (self = [super init])
    {
        _onlineCreditCardProcesor = @"ONLINE_CREDIT_CARD_PROCESSOR";
        _payPal = @"PAYPAL";
        _googleCheckout = @"GOOGLE_CHECKOUT";
        _check = @"CHECK";
        _door = @"DOOR";
    }
    return self;
}

@end
