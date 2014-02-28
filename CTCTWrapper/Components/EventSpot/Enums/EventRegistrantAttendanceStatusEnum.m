//
//  EventRegistrantAttendanceStatusEnum.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "EventRegistrantAttendanceStatusEnum.h"

@implementation EventRegistrantAttendanceStatusEnum

- (id)init
{
    if (self = [super init])
    {
        _attended = @"ATTENDED";
        _notAttended = @"NOT_ATTENDED";
    }
    return self;
}

@end
