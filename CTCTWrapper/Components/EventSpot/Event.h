//
//  Event.h
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EventStatusEnum.h"
#import "EventTypeEnum.h"
#import "EventAddress.h"
#import "Component.h"

@interface Event : NSObject

/**
 * Date the event was created in ISO-8601 format
 */
@property (nonatomic, strong) NSString *createdDate;
/**
 * Time zone in which the event occurs
 * valid values found at https://community.constantcontact.com/t5/Documentation/Events-Collection-and-Resource/ba-p/25081
 */
@property (nonatomic, strong) NSString *timeZoneId;
/**
 * Name of the venue or Location at which the event is being held
 */
@property (nonatomic, strong) NSString *location;
/**
 * The event status, valid values can be found in EventStatusEnum class
 */
@property (nonatomic, strong) NSString *status;
/**
 * URI that points to the detailed description of that event, provides the same information as performing a GET on a specific event.
 */
@property (nonatomic, strong) NSString *eventDetailUrl;
/**
 * Number of event registrants
 */
@property (nonatomic, readwrite) int totalRegisteredCount;
/**
 * Points to the event homepage if configured, otherwise points to the event registration page
 */
@property (nonatomic, strong) NSString *registrationUrl;
/**
 * Date event was published or announced, in ISO-8601 format
 */
@property (nonatomic, strong, readonly) NSString *activeDate;
/**
 * The event type, valid values are available in EventTypeEnum class
 */
@property (nonatomic, strong) NSString *type;
/**
 * Unique ID of the event
 */
@property (nonatomic, strong) NSString *eventId;
/**
 * Set to true to enable registrant check-in, and indicate that the registrant attended the event
 */
@property (nonatomic, readwrite) BOOL isCheckinAvailable;
/**
 * Date the event was deleted in ISO-8601 format
 */
@property (nonatomic, strong) NSString *deleteDate;
/**
 * The event title, visible to registrants
 */
@property (nonatomic, strong) NSString *title;
/**
 * The event end date, in ISO-8601 format
 */
@property (nonatomic, strong) NSString *endDate;
/**
 * Address specifying the event location, used to determine event location on map if is_map_displayed set to true.
 */
@property (nonatomic, strong) EventAddress *addresses;
/**
 * Provide a brief description of the event that will be visible on the event registration form and landing page
 */
@property (nonatomic, strong) NSString *description;
/**
 * The event filename - not visible to registrants
 */
@property (nonatomic, strong) NSString *name;
/**
 * The event start date, in ISO-8601 format
 */
@property (nonatomic, strong) NSString *startDate;

/**
 * Enumeration class that contains valid options for event status element
 */
@property (nonatomic, strong, readonly) EventStatusEnum *eventStatusEnum;

/**
 * Enumeration class that contains valid options for event type element
 */
@property (nonatomic, strong, readonly) EventTypeEnum *eventTypeEnum;


/**
 * Factory method to create a Event object from an dictionary
 *
 * @param NSDictionary *dictionary - associative dictionary of initial properties to set
 *
 * @return Event
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (Event *)eventWithDictionary:(NSDictionary *)dictionary;

- (NSString*)JSON;

@end
