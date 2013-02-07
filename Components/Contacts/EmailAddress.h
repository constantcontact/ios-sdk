//
//  EmailAddress.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Component.h"

@interface EmailAddress : NSObject

@property (nonatomic, assign) NSString *confirmStatus;
@property (nonatomic, assign) NSString *emailAddress;
@property (nonatomic, assign) NSDate *optInDate;
@property (nonatomic, assign) NSString *optInSource;
@property (nonatomic, assign) NSDate *optOutDate;
@property (nonatomic, assign) NSString *status;

-(id)initWithEmailAddress:(NSString *)emailAddress;
-(id)initWithDictionary:(NSDictionary *)dictionary;
+(EmailAddress*)addressWithDictionary:(NSDictionary *)dictionary;
-(id) proxyForJson;

@end
