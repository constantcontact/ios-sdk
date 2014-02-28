//
//  RegistrantPaymentSummary.h
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EventRegistrantPaymentTypeEnum.h"
#import "RegistrantPromoCode.h"
#import "RegistrantOrder.h"
#import "Component.h"

@interface RegistrantPaymentSummary : NSObject

/**
 * Payment type , valid values found in EventRegistrantPaymentTypeEnum
 */
@property (nonatomic, strong) NSString *paymentType;
/**
 * Status of the payment.
 */
@property (nonatomic, strong) NSString *paymentStatus;
/**
 * Promocode information
 */
@property (nonatomic, strong) RegistrantPromoCode *promocode;

@property (nonatomic, strong) RegistrantOrder *order;

/**
 * Enumeration class that contains valid options for event status element
 */
@property (nonatomic, strong) EventRegistrantPaymentTypeEnum *eventRegistrantPaymentTypeEnum;

/**
 * Factory method to create a Registrant payment summary object from an dictionary
 *
 * @param NSDictionary *dictionary - associative dictionary of initial properties to set
 *
 * @return RegistrantPaymentSummary
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (RegistrantPaymentSummary *)registrantPaymentSummartWithDictionary:(NSDictionary *)dictionary;

- (NSString*)JSON;

@end
