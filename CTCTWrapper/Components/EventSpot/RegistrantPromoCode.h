//
//  RegistrantPromoCode.h
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RegistrantPromocodeInfo.h"
#import "Component.h"

@interface RegistrantPromoCode : NSObject

/**
 * Total discount value
 */
@property (nonatomic, readwrite) double totalDiscount;
/**
 * Promocode information item;
 */
@property (nonatomic, strong) RegistrantPromocodeInfo *promocodeInfo;

/**
 * Factory method to create a registrant promo code object from an dictionary
 *
 * @param NSDictionary *dictionary - associative dictionary of initial properties to set
 *
 * @return RegistrantPromoCode
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (RegistrantPromoCode *)registrantPromoCodeWithDictionary:(NSDictionary *)dictionary;

- (NSString*)JSON;



@end
