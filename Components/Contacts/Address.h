//
//  Address.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contactv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Component.h"

@interface Address : NSObject

@property (nonatomic, assign) NSString *addressType;
@property (nonatomic, assign) NSString *city;
@property (nonatomic, assign) NSString *countryCode;
@property (nonatomic, assign) NSString *line1;
@property (nonatomic, assign) NSString *line2;
@property (nonatomic, assign) NSString *line3;
@property (nonatomic, assign) NSString *postalCode;
@property (nonatomic, assign) NSString *stateCode;
@property (nonatomic, assign) NSString *subPostalCode;

-(id)initWithDictionary:(NSDictionary *)dictionary;
+(Address*)addressWithDictionary:(NSDictionary *)dictionary;

@end
