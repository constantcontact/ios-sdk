//
//  EventStatusEnum.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "EventStatusEnum.h"

@implementation EventStatusEnum

- (id)init
{
    if (self = [super init])
    {
        _draft = @"DRAFT";
        _active = @"ACTIVE";
        _complete = @"COMPLETE";
        _cancelled = @"CANCELLED";
        _deleted = @"DELETED";
    }
    return self;
}

@end
