//
//  EmailAddress.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Component.h"

@interface EmailAddress : NSObject

@property (nonatomic, strong, readonly) NSString *emailId;
@property (nonatomic, strong) NSString *confirmStatus;
@property (nonatomic, strong) NSString *emailAddress;
@property (nonatomic, strong) NSDate *optInDate;
@property (nonatomic, strong) NSString *optInSource;
@property (nonatomic, strong) NSDate *optOutDate;
@property (nonatomic, strong) NSString *status;

- (id)initWithEmailAddress:(NSString *)emailAddress;
- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (EmailAddress *)emailAddressWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary*)proxyForJSON;

@end
