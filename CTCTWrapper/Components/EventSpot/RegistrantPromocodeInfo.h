//
//  RegistrantPromocodeInfo.h
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EventRegistrantDiscountScopeEnum.h"
#import "PromocodeDiscountTypeEnum.h"
#import "Component.h"

@interface RegistrantPromocodeInfo : NSObject

/**
 * Name for the promo code
 */
@property (nonatomic, strong) NSString *codeName;
/**
 * Code type for the promo code
 */
@property (nonatomic, strong) NSString *codeType;
/**
 * Redemption count
 */
@property (nonatomic, readwrite) int redemptionCount;
/**
 * Discount scope ,valid values in EventRegistrantDiscoutScopeEnum class
 */
@property (nonatomic, strong) NSString *discoutScope;
/**
 * Discount amount
 */
@property (nonatomic, readwrite) double discountAmount;
/**
 * Discount percentage
 */
@property (nonatomic, readwrite) double discountPercent;
/**
 * Discount type, valid values in PromocodeDiscountTypeEnum
 */
@property (nonatomic, strong) NSString *discountType;

/**
 * Enumeration class that contains valid options for event attendance status element
 */
@property (nonatomic, strong) PromocodeDiscountTypeEnum *discountTypeEnum;

/**
 * Enumeration class that contains valid options for event attendance status element
 */
@property (nonatomic, strong) EventRegistrantDiscountScopeEnum *eventRegistrantDiscountScopeEnum;

/**
 * Factory method to create a Promocode info object from an dictionary
 *
 * @param NSDictionary *dictionary - associative dictionary of initial properties to set
 *
 * @return RegistrantPromocodeInfo
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (RegistrantPromocodeInfo *)promocodeInfoWithDictionary:(NSDictionary *)dictionary;

- (NSString*)JSON;

@end
