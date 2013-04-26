//
//  HttpResponse.m
//  ConstantContact
//
//  Created by Sergiu Grigoriev on 3/25/13.
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "HttpResponse.h"

@implementation HttpResponse

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _requestURL = (NSString*)[dictionary objectForKey:KEY_REQUEST_URL];
        _responseURL = (NSString*)[dictionary objectForKey:KEY_RESPONSE_URL];
        _statusCode = [[dictionary objectForKey:KEY_STATUS_CODE] intValue];
        _data = [dictionary objectForKey:KEY_DATA];
        
        NSArray *errorsArray = [dictionary objectForKey:KEY_ERRORS];
        NSMutableArray *newErrorsArray = [[NSMutableArray alloc] initWithCapacity:errorsArray.count];
        
        for (NSDictionary *errorDict in errorsArray)
        {
            HttpError *error = [[HttpError alloc] initWithDictionary:errorDict];
            [newErrorsArray addObject:error];
        }
        
        _errors = [newErrorsArray copy];

    }
    
    return self;
}

- (NSString*)description
{
    NSMutableString *desc = [[NSMutableString alloc] initWithFormat:@"<HttpResponse: %p>", self];
    [desc appendFormat:@"\n%@: %d", KEY_STATUS_CODE, self.statusCode];
    [desc appendFormat:@"\n%@: %@", KEY_REQUEST_URL, self.requestURL];
    [desc appendFormat:@"\n%@: %@", KEY_RESPONSE_URL, self.responseURL];
    [desc appendFormat:@"\n%@: %@", KEY_DATA, self.data];
    [desc appendFormat:@"\n%@: %@", KEY_ERRORS, self.errors];
    
    return desc;
}

- (void)replaceDataWithNewData:(id)newData
{
    _data = newData;
}

@end
