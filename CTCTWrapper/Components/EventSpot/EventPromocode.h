//
//  EventPromocode.h
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PromocodeDiscountScopeEnum.h"
#import "PromocodeDiscountTypeEnum.h"
#import "PromocodeCodeTypeEnum.h"
#import "PromocodeStatusEnum.h"
#import "Component.h"

@interface EventPromocode : NSObject

/**
 * REQUIRED. Name of the promotional code visible to registrants, between 4 - 12 characters, cannot contain spaces or special character (_ is OK); each code_name must be unique
 */
@property (nonatomic, strong) NSString *codeName;
/**
 * REQUIRED. Type of promocode, valid values are found in PromocodeCodeTypeEnum
 */
@property (nonatomic, strong) NSString *codeType;
/**
 * Specifies a fixed discount amount, minimum of 0.01, is required when code_type = DISCOUNT, but not using discount_percent
 */
@property (nonatomic, readwrite) double discountAmount;
/**
 * Specifies a discount percentage, from 1% - 100%, is required when code_type = DISCOUNT, but not using discount_amount
 */
@property (nonatomic, readwrite) int discountPercentage;
/**
 * Required when code_type = DISCOUNT; valid values in PromocodeDiscountScopeEnum class
 */
@property (nonatomic, strong) NSString *discountScope;
/**
 * Discount types; valid values in PromocodeDiscountTypeEnum class
 */
@property (nonatomic, strong, readonly) NSString *discoutType;
/**
 * Identifies the fees to which the promocode applies;
 */
@property (nonatomic, strong) NSMutableArray *feeIds;
/**
 * Unique ID for the event promotional code
 */
@property (nonatomic, strong, readonly) NSString *promocodeId;
/**
 * REQUIRED. When set to true, promocode cannot be redeemed; when false, promocode can be redeemed; default = false.
 */
@property (nonatomic, readwrite) BOOL isPaused;
/**
 * Number of promocodes available for redemption; -1 = unlimited
 */
@property (nonatomic, readonly) int quantityAvailable;
/**
 * REQUIRED. Total number of promocodes available for redemption; -1 = unlimited.
 */
@property (nonatomic, readwrite) int quantityTotal;
/**
 * Number of promocodes that have been redeemed; starts at 0
 */
@property (nonatomic, readonly) int quantityUsed;
/**
 * Status of the promocode, valid values are found in PromocodeStatusEnum class
 */
@property (nonatomic, strong, readonly) NSString *status;


/**
 * Enumeration class that contains valid options for the discount scope element
 */
@property (nonatomic, strong, readonly) PromocodeDiscountScopeEnum *promocodeDiscountScopeEnum;

/**
 * Enumeration class that contains valid options for the discount type element
 */
@property (nonatomic, strong, readonly) PromocodeDiscountTypeEnum *promocodeDiscountTypeEnum;

/**
 * Enumeration class that contains valid options for the code type element
 */
@property (nonatomic, strong, readonly) PromocodeCodeTypeEnum *promocodeCodeTypeEnum;

/**
 * Enumeration class that contains valid options for the status element
 */
@property (nonatomic, strong, readonly) PromocodeStatusEnum *promocodeStatusEnum;

/**
 * Factory method to create a Event Promocode object from an dictionary
 *
 * @param NSDictionary *dictionary - associative dictionary of initial properties to set
 *
 * @return EventPromocode
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (EventPromocode *)promocodeWithDictionary:(NSDictionary *)dictionary;

- (NSString*)JSON;

@end
