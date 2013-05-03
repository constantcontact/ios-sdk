//
//  Address.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contactv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Component.h"

@interface Address : NSObject

@property (nonatomic, strong, readonly) NSString *addressId;
@property (nonatomic, strong) NSString *addressType;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *countryCode;
@property (nonatomic, strong) NSString *line1;
@property (nonatomic, strong) NSString *line2;
@property (nonatomic, strong) NSString *line3;
@property (nonatomic, strong) NSString *postalCode;
@property (nonatomic, strong) NSString *stateCode;
@property (nonatomic, strong) NSString *subPostalCode;
@property (nonatomic, strong) NSString *stateProvince;

- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (Address *)addressWithDictionary:(NSDictionary *)dictionary;
- (NSDictionary*)proxyForJSON;
- (NSString*)JSON;

@end
