//
//  EventFee.h
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FeeScopeEnum.h"
#import "Component.h"

@interface EventFee : NSObject

/**
 * Fee for registrations that occur prior to the event's early_fee_date
 */
@property (nonatomic, readwrite) double earlyFee;
/**
 * REQUIRED. The fee amount
 */
@property (nonatomic, readwrite) double fee;
/**
 * REQUIRED. Specifies who the fee applies to, valid values can be found in FeeScopeEnum class
 */
@property (nonatomic, strong) NSString *feeScope;
/**
 * Unique ID for that fee
 */
@property (nonatomic, strong, readonly) NSString *feeId;
/**
 * REQUIRED. Fee description displayed to event registrants
 */
@property (nonatomic, strong) NSString *label;
/**
 * Fee for registrations that occur after the event's late_fee_date
 */
@property (nonatomic, readwrite) double lateFee;

/**
 * Enumeration class that contains valid options for fee scope element
 */
@property (nonatomic, strong, readonly) FeeScopeEnum *feeScopeEnum;

/**
 * Factory method to create a Event fee object from an dictionary
 *
 * @param NSDictionary *dictionary - associative dictionary of initial properties to set
 *
 * @return EventFee
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (EventFee *)eventFeeWithDictionary:(NSDictionary *)dictionary;

- (NSString*)JSON;

@end
