//
//  Thumbnail.m
//  CTCTContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "Thumbnail.h"

@implementation Thumbnail

- (id)init
{
    if (self = [super init])
    {
        _height = 0;
        _url = @"";
        _width = 0;
    }
    
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _height = [[Component valueForDictionary:dictionary withKey:@"height"] intValue];
        _url = [Component valueForDictionary:dictionary withKey:@"url"];
        _width = [[Component valueForDictionary:dictionary withKey:@"width"] intValue];
    }
    return self;
}

+ (Thumbnail *)thumbnailWithDictionary:(NSDictionary *)dictionary
{
    Thumbnail *thumb = [[Thumbnail alloc] initWithDictionary:dictionary];
    
    return thumb;
}

@end
