//
//  EventCurrencyTypeEnum.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "EventCurrencyTypeEnum.h"

@implementation EventCurrencyTypeEnum

- (id)init
{
    if (self = [super init])
    {
        _usd = @"USD";
        _cad = @"CAD";
        _aud = @"AUD";
        _chf = @"CHF";
        _czk = @"CZK";
        _dkk = @"DKK";
        _eur = @"EUR";
        _gbp = @"GBP";
        _hkd = @"HKD";
        _huf = @"HUF";
        _ils = @"ILS";
        _jpy = @"JPY";
        _mxn = @"MXN";
        _nok = @"NOK";
        _nzd = @"NZD";
        _php = @"PHP";
        _pln = @"PLN";
        _sek = @"SEK";
        _sgd = @"SGD";
        _thb = @"THB";
        _twd = @"TWD";
    }
    return self;
}

@end
