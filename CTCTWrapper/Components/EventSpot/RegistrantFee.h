//
//  RegistrantFee.h
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Component.h"

@interface RegistrantFee : NSObject

/**
 * Amount paid.
 */
@property (nonatomic, readwrite) float amount;
/**
 * Fee ID
 */
@property (nonatomic, strong, readonly) NSString *feeId;
/**
 * Promo type
 */
@property (nonatomic, readwrite) double promoType;
/**
 * Name of registrant or guest
 */
@property (nonatomic, strong) NSString *name;
/**
 * Number of items in guests
 */
@property (nonatomic, readwrite) int quantity;
/**
 * Type of fees.
 */
@property (nonatomic, strong) NSString *type;
/**
 * Fee period type
 */
@property (nonatomic, strong) NSString *feePeriodType;

/**
 * Factory method to create a Registrant fee object from an dictionary
 *
 * @param NSDictionary *dictionary - associative dictionary of initial properties to set
 *
 * @return RegistrantFee
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (RegistrantFee *)registrantFeeWithDictionary:(NSDictionary *)dictionary;

- (NSString*)JSON;

@end
