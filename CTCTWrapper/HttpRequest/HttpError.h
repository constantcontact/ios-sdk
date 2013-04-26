//
//  HttpError.h
//  ConstantContact
//
//  Created by Sergiu Grigoriev on 3/25/13.
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpError : NSObject

@property (nonatomic, strong, readonly) NSString *key;
@property (nonatomic, strong, readonly) NSString *message;

- (id)initWithDictionary:(NSDictionary*)dictionary;

@end
