//
//  EventRegistrantExtended.h
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EventRegistrantAttendanceStatusEnum.h"
#import "RegistrantPaymentSummary.h"
#import "RegistrantPromocodeInfo.h"
#import "RegistrantSection.h"
#import "RegistrantGuest.h"
#import "Component.h"

@interface EventRegistrantExtended : NSObject

/**
 * The Registrant's attendance status, values found in EventRegistrantAttendanceStatusEnum class
 */
@property (nonatomic, strong) NSString *attendanceStatus;
/**
 * An object containing guest properties
 */
@property (nonatomic, strong) RegistrantGuest *guests;
/**
 * Unique ID for the registrant
 */
@property (nonatomic, strong) NSString *registrantId;
/**
 * Unique ID of the registrant's event ticket
 */
@property (nonatomic, strong) NSString *ticketId;
/**
 * Field sections displayed
 */
@property (nonatomic, strong) NSMutableArray *sections;
/**
 * The Registrant's registration status
 */
@property (nonatomic, strong) NSString *registrantStatus;
/**
 * Date the registrant registered for the event
 */
@property (nonatomic, strong) NSString *registrationDate;
/**
 * Payment status information object
 */
@property (nonatomic, strong) RegistrantPaymentSummary *paymentSummary;

/**
 * Enumeration class that contains valid options for event attendance status element
 */
@property (nonatomic, strong) EventRegistrantAttendanceStatusEnum *eventRegistrantAttendanceStatusEnum;

/**
 * Factory method to create a extended event registrant object from an dictionary
 *
 * @param NSDictionary *dictionary - associative dictionary of initial properties to set
 *
 * @return EventRegistrantExtended
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (EventRegistrantExtended *)eventRegistrantExtendedWithDictionary:(NSDictionary *)dictionary;

@end
