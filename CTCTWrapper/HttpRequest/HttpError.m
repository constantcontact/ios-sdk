//
//  HttpError.m
//  ConstantContact
//
//  Created by Sergiu Grigoriev on 3/25/13.
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "HttpError.h"

@implementation HttpError

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _key = (NSString*)[dictionary objectForKey:@"error_key"];
        _message = (NSString*)[dictionary objectForKey:@"error_message"];
    }
    
    return self;
}

@end
