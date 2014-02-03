//
//  ClickThroughDetails.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "ClickThroughDetails.h"

@implementation ClickThroughDetails

- (id)init
{
    if (self = [super init])
    {
        _url = @"";
        _urlUid = @"";
        _clickCount = 0;
    }

    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _url = [Component valueForDictionary:dictionary withKey:@"url"];
        _urlUid = [Component valueForDictionary:dictionary withKey:@"url_uid"];
        _clickCount = [[Component valueForDictionary:dictionary withKey:@"click_count"] intValue];
    }
    return self;
}

+ (ClickThroughDetails *)clickThroughDetailsWithDictionary:(NSDictionary *)dictionary;
{
    ClickThroughDetails *clickThroughDetails = [[ClickThroughDetails alloc] initWithDictionary:dictionary];

    return clickThroughDetails;
}

@end
