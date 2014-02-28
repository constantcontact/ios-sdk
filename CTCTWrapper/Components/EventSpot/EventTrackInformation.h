//
//  EventTrackInformation.h
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EventInformationSectionsEnum.h"
#import "Component.h"

@interface EventTrackInformation : NSObject

/**
 * Date on which early fees end, in ISO-8601 format
 */
@property (nonatomic, strong) NSString *earlyFeeDate;
/**
 * Default = Guest(s); How guests are referred to on the registration form; use your own, or one of the following suggestions are Associate(s), Camper(s), Child(ren), Colleague(s), Employee(s), Friend(s), Guest(s), Member(s), Participant(s), Partner(s), Player(s), Spouse(s), Student(s), Teammate(s), Volunteer(s)
 */
@property (nonatomic, strong) NSString *guestDisplayLabel;
/**
 * Number of guests each registrant can bring, 0 - 100, default = 0
 */
@property (nonatomic, readwrite) int guestLimit;
/**
 * Determines if the Who (CONTACT), When (TIME), or Where (LOCATION) information is shown on the Event page. Default settings are CONTACT, TIME, and LOCATION ;
 * CONTACT - displays the event contact information
 * TIME - displays the event date and time
 * LOCATION - displays the event location
 */
@property (nonatomic, strong) NSMutableArray *informationSections;
/**
 * Default = false; Set to true to display the guest count field on the registration form; if true, is_guest_name_required must be set to false (default).
 */
@property (nonatomic, readwrite) BOOL isGuestAnonymusEnabled;
/**
 * Default = false. Set to display guest name fields on registration form; if true, then is_guest_anonymous_enabled must be set false (default).
 */
@property (nonatomic, readwrite) BOOL isGuestNameRequired;
/**
 * Default = false; Manually closes the event registration when set to true, takes precedence over registration_limit_date and registration_limit_count settings
 */
@property (nonatomic, readwrite) BOOL isRegistrationClosedManually;
/**
 * Default = false; Set to true provide a link for registrants to retrieve an event ticket after they register.
 */
@property (nonatomic, readwrite) BOOL isTicketingLinkDisabled;
/**
 * Date after which late fees apply, in ISO-8601 format
 */
@property (nonatomic, strong) NSString *lateFeeDate;
/**
 * Specifies the maximum number of registrants for the event
 */
@property (nonatomic, readwrite) int registrationLimitCount;
/**
 * Date when event registrations close, in ISO-8601 format
 */
@property (nonatomic, strong) NSString *registrationLimitDate;


/**
 * Enumeration class that contains valid options for event payment potions element
 */
@property (nonatomic, strong) EventInformationSectionsEnum *informationSectionsEnum;

/**
 * Factory method to create a Event Track Information object from an dictionary
 *
 * @param NSDictionary *dictionary - associative dictionary of initial properties to set
 *
 * @return EventTrackInformation
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (EventTrackInformation *)eventTrackInfoWithDictionary:(NSDictionary *)dictionary;

- (NSString*)JSON;

@end
