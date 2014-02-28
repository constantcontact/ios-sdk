//
//  FeeScopeEnum.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "FeeScopeEnum.h"

@implementation FeeScopeEnum

- (id)init
{
    if (self = [super init])
    {
      _bouth = @"BOTH";
      _registrants = @"REGISTRANTS";
      _guests = @"GUESTS";
    }
    return self;
}


@end
