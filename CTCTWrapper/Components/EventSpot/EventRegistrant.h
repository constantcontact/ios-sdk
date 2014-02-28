//
//  EventRegistrant.h
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EventRegistrantAttendanceStatusEnum.h"
#import "Component.h"

@interface EventRegistrant : NSObject

/**
 * Unique ID for the registrant
 */
@property (nonatomic, strong) NSString *registrantId;
/**
 * Unique ID of the registrant's event ticket
 */
@property (nonatomic, strong) NSString *ticketId;
/**
 * Number of guests the registrant is bringing to the event
 */
@property (nonatomic, readwrite) int guestCount;
/**
 * The Registrant's first (given) name
 */
@property (nonatomic, strong) NSString *firstName;
/**
 * Most recent date registrant was updated
 */
@property (nonatomic, strong) NSString *updatedDate;
/**
 * The Registrant's registration status
 */
@property (nonatomic, strong) NSString *registrationStatus;
/**
 * The Registrant's email address
 */
@property (nonatomic, strong) NSString *email;
/**
 * Date the registrant registered for the event
 */
@property (nonatomic, strong) NSString *registrationDate;
/**
 * The Registrant's last (family) name
 */
@property (nonatomic, strong) NSString *lastName;
/**
 * The Registrant's attendance status, valid values in EventRegistrantAttendanceStatusEnum class
 */
@property (nonatomic, strong) NSString *attendanceStatus;
/**
 * The Registrant's payment status
 */
@property (nonatomic, strong) NSString *paymentStatus;

/**
 * Enumeration class that contains valid options for the discount scope element
 */
@property (nonatomic, strong, readonly) EventRegistrantAttendanceStatusEnum *eventRegistrantAttendanceStatusEnum;

/**
 * Factory method to create a Event registrant object from an dictionary
 *
 * @param NSDictionary *dictionary - associative dictionary of initial properties to set
 *
 * @return EventRegistrant
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (EventRegistrant *)eventRegistrantWithDictionary:(NSDictionary *)dictionary;

- (NSString*)JSON;

@end
