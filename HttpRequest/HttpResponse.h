//
//  HttpResponse.h
//  ConstantContact
//
//  Created by Sergiu Grigoriev on 3/25/13.
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpError.h"

#define KEY_STATUS_CODE @"statusCode"
#define KEY_DATA @"data"
#define KEY_REQUEST_URL @"requestURL"
#define KEY_RESPONSE_URL @"responseURL"
#define KEY_ERRORS @"errors"

@interface HttpResponse : NSObject

@property (nonatomic, readonly) int statusCode;
@property (nonatomic, strong, readonly) id data;
@property (nonatomic, strong, readonly) NSArray *errors;
@property (nonatomic, strong, readonly) NSString *requestURL;
@property (nonatomic, strong, readonly) NSString *responseURL;

- (id)initWithDictionary:(NSDictionary*)dictionary;
- (void)replaceDataWithNewData:(id)newData;

@end
