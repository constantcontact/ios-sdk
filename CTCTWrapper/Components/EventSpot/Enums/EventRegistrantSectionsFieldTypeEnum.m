//
//  EventRegistrantSectionsFieldTypeEnum.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "EventRegistrantSectionsFieldTypeEnum.h"

@implementation EventRegistrantSectionsFieldTypeEnum

- (id)init
{
    if (self = [super init])
    {
        _singleValue = @"single_value";
        _multipleValue = @"multiple_values";
    }
    return self;
}

@end
