//
//  EventPatchValueEnum.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "EventPatchValueEnum.h"

@implementation EventPatchValueEnum

- (id)init
{
    if (self = [super init])
    {
        _valueActive = @"ACTIVE";
        _valueCanceled = @"CANCELLED";
    }
    return self;
}

@end
