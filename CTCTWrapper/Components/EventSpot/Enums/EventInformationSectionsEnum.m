//
//  EventInformationSectionsEnum.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "EventInformationSectionsEnum.h"

@implementation EventInformationSectionsEnum

- (id)init
{
    if (self = [super init])
    {
        _contact = @"CONTACT";
        _time = @"TIME";
        _location = @"LOCATION";
    }
    return self;
}

@end
