//
//  PromocodeStatusEnum.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "PromocodeStatusEnum.h"

@implementation PromocodeStatusEnum

- (id)init
{
    if (self = [super init])
    {
        _live = @"LIVE";
        _paused = @"PAUSED";
        _depleted = @"DEPLETED";
    }
    return self;
}

@end
