//
//  RegistrantSaleItem.h
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Component.h"

@interface RegistrantSaleItem: NSObject

/**
 * Amount paid.
 */
@property (nonatomic, readwrite) float amount;
/**
 * Fee ID
 */
@property (nonatomic, strong) NSString *saleItemId;
/**
 * Amount paid.
 */
@property (nonatomic, readwrite) float promoType;
/**
 * Name of registrant or guest
 */
@property (nonatomic, strong) NSString *name;
/**
 * Number of amount required.
 */
@property (nonatomic, readwrite) int quantity;
/**
 * Type of fees
 */
@property (nonatomic, strong) NSString *type;
/**
 * Amount paid.
 */
@property (nonatomic, readwrite) float feePeriodType;

/**
 * Factory method to create a Registrant sale item object from an dictionary
 *
 * @param NSDictionary *dictionary - associative dictionary of initial properties to set
 *
 * @return RegistrantSaleItem
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (RegistrantSaleItem *)saleItemWithDictionary:(NSDictionary *)dictionary;

@end
