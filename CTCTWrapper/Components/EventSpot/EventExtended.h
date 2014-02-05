//
//  EventExtended.h
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EventNotificationOptions.h"
#import "EventCurrencyTypeEnum.h"
#import "EventTrackInformation.h"
#import "EventPaymentTypeEnum.h"
#import "EventOnlineMeeting.h"
#import "EventStatusEnum.h"
#import "EventTypeEnum.h"
#import "EventAddress.h"
#import "EventContact.h"
#import "Component.h"

@interface EventExtended : NSObject

/**
 * Date event was published or announced, in ISO-8601 format 
 */
@property (nonatomic, strong, readonly) NSString *activeDate;
/**
 * Address specifying the event location, used to determine event location on map if is_map_displayed set to true.
 */
@property (nonatomic, strong) EventAddress *address;
/**
 * Set to true allows registrants to view others who have registered for the event, Default is false
 */
@property (nonatomic, readwrite) BOOL areRegistrantsPublic;
/**
 * Date the event was cancelled in ISO-8601 format
 */
@property (nonatomic, strong, readonly) NSString *cancelledDate;
/**
 * REQUIRED. The event host's contact information
 */
@property (nonatomic, strong) EventContact *contact;
/**
 * Date the event was created in ISO-8601 format 
 */
@property (nonatomic, strong, readonly) NSString *createdDate;
/**
 * Currency that the account will be paid in; although this is not a required field, it has a default value of USD. Other valid values in EventCurrencyTypeEnum
 */
@property (nonatomic, strong) NSString *currencyType;
/**
 * Date the event was deleted in ISO-8601 format
 */
@property (nonatomic, strong, readonly) NSString *deleteDate;
/**
 * Provide a brief description of the event that will be visible on the event registration form and landing page
 */
@property (nonatomic, strong) NSString *description;
/**
 * REQUIRED. The event end date, in ISO-8601 format
 */
@property (nonatomic, strong) NSString *endDate;
/**
 * Enter the Google analytics key if being used to track the event registration homepage
 */
@property (nonatomic, strong) NSString *googleAnalyticsKey;
/**
 * Google merchant id to which payments are made; Google Checkout is not supported for new events, only valid on events created prior to October 2013.
 */
@property (nonatomic, strong) NSString *googleMerchantId;
/**
 * Unique ID of the event
 */
@property (nonatomic, strong, readonly) NSString *eventId;
/**
 * Set to true to display the event on the account's calendar; Default = true
 */
@property (nonatomic, readwrite) BOOL isCalendarDisplayed;
/**
 * Set to true to enable registrant check-in, and indicate that the registrant attended the event; Default is false
 */
@property (nonatomic, readwrite) BOOL isCheckinAvailable;
/**
 * Indicates if the event home/landing page is displayed for the event; set to true only if a landing page has been created for the event; Default is false
 */
@property (nonatomic, readwrite) BOOL isHomePageDisplayed;
/**
 * Set to true to publish the event in external event directories such as SocialVents and EventsInAmerica; Default is false
 */
@property (nonatomic, readwrite) BOOL isListedInExternalDirectory;
/**
 * For future usage, Default = true
 */
@property (nonatomic, readwrite) BOOL isMapDisplayed;
/**
 * Set to true if this is an online event; Default is false
 */
@property (nonatomic, readwrite) BOOL isVirtualEvent;
/**
 * REQUIRED. Name of the venue or Location at which the event is being held
 */
@property (nonatomic, strong) NSString *location;
/**
 * Specify keywords to improve search engine optimization (SEO) for the event; use commas to separate multiple keywords
 */
@property (nonatomic, strong) NSString *metaDataTags;
/**
 * REQUIRED. The event filename - not visible to registrants
 */
@property (nonatomic, strong) NSString *name;
/**
 * Define whether or not event notifications are sent to the contact email_address, and which notifications.
 */
@property (nonatomic, strong) NSMutableArray *notificationOptions;
/**
 * Online meeting details, REQUIRED if is_virtual_event is set to true
 */
@property (nonatomic, strong) EventOnlineMeeting *onlineMeeting;
/**
 * Name to which registrants paying by check must make checks payable to; REQUIRED if 'CHECK' is selected as a payment option
 */
@property (nonatomic, strong) NSString *payableTo;
/**
 * Address to which checks will be sent. REQUIRED if CHECK is selected as a payment option
 */
@property (nonatomic, strong) EventAddress *paymentAddress;
/**
 * Specifies the payment options available to registrants
 */
@property (nonatomic, strong) NSMutableArray *paymentOptions;
/**
 * Email address linked to PayPal account to which payments will be made. REQUIRED if 'PAYPAL' is selected as a payment option
 */
@property (nonatomic, strong) NSString *paypalAccountEmail;
/**
 * The URL for the event home page if one exists, otherwise it points to the event registration page (Read Only)
 */
@property (nonatomic, strong, readonly) NSString *registrationUrl;
/**
 * REQUIRED. The event start date, in ISO-8601 format
 */
@property (nonatomic, strong) NSString *startDate;
/**
 * The event status, valid values are found in EventStatusEnum class
 */
@property (nonatomic, strong, readonly) NSString *status;
/**
 * The background and color theme for the event invitation, home page, and Registration form; default is Default
 */
@property (nonatomic, strong) NSString *themeName;
/**
 * REQUIRED. Time zone in which the event occurs
 */
@property (nonatomic, strong) NSString *timeZoneDescription;
/**
 * REQUIRED. The event title, visible to registrants
 */
@property (nonatomic, strong) NSString *timeZoneId;
/**
 * REQUIRED. The event title, visible to registrants
 * valid values found at https://community.constantcontact.com/t5/Documentation/Events-Collection-and-Resource/ba-p/25081
 */
@property (nonatomic, strong) NSString *title;
/**
 * Number of event registrants
 */
@property (nonatomic, strong, readonly) NSString *totalRegisteredCount;
/**
 * Use these settings to define the information displayed on the Event registration page
 */
@property (nonatomic, strong) EventTrackInformation *trackInformation;
/**
 * The event's Twitter hashtag
 */
@property (nonatomic, strong) NSString *twitterHashTag;
/**
 * REQUIRED. The event type, valid values are found in EventTypeEnum class
 */
@property (nonatomic, strong) NSString *type;
/**
 * Date the event was updated in ISO-8601 format 
 */
@property (nonatomic, strong, readonly) NSString *updateDate;

/**
 * Enumeration class that contains valid options for the currency element
 */
@property (nonatomic, strong, readonly) EventCurrencyTypeEnum *eventCurrencyTypeEnum;

/**
 * Enumeration class that contains valid options for event status element
 */
@property (nonatomic, strong, readonly) EventStatusEnum *eventStatusEnum;

/**
 * Enumeration class that contains valid options for event type element
 */
@property (nonatomic, strong, readonly) EventTypeEnum *eventTypeEnum;

/**
 * Enumeration class that contains valid options for event payment potions element
 */
@property (nonatomic, strong) EventPaymentTypeEnum *eventPaymentTypeEnum;

/**
 * Factory method to create a Event Extended object from an dictionary
 *
 * @param NSDictionary *dictionary - associative dictionary of initial properties to set
 *
 * @return EventExtended
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (EventExtended *)eventExtendedWithDictionary:(NSDictionary *)dictionary;

- (NSString*)JSON;

@end
