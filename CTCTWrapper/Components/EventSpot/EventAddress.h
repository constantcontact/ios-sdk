//
//  EventAddress.h
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Component.h"

@interface EventAddress : NSObject

/**
 * City of the event location
 */
@property (nonatomic, strong) NSString *city;
/**
 * Country of the event location
 */
@property (nonatomic, strong) NSString *country;
/**
 * Standard 2 letter ISO 3166-1 code of the country associated with the event address
 */
@property (nonatomic, strong) NSString *countryCode;
/**
 * Latitude coordinates of the event location, not used to determine event Location on map if is_map_displayed set to true
 */
@property (nonatomic, readwrite) double latitude;
/**
 * Longitude coordinates of the event location, , not used to determine event Location at this time on map if is_map_displayed set to true
 */
@property (nonatomic, readwrite) double longitude;
/**
 * Event address line 1
 */
@property (nonatomic, strong) NSString *line1;
/**
 * Event address line 2
 */
@property (nonatomic, strong) NSString *line2;
/**
 * Event address line 3
 */
@property (nonatomic, strong) NSString *line3;
/**
 * Postal ZIP code for the event
 */
@property (nonatomic, strong) NSString *postalCode;
/**
 * Name of the state or province the event is located in. For US or CA, this field is overwritten by the state/province name derived from the state_code, if entered.
 */
@property (nonatomic, strong) NSString *state;
/**
 * Use ONLY for the standard 2 letter abbreviation for the US state or Canadian province where the event is located;
 *An error occurs if state_code is populated for non-US or Canadian country;
 *if state_code is entered, the system overwrites the state property with the resolved state or province name.
 */
@property (nonatomic, strong) NSString *stateCode;

/**
 * Factory method to create a Event Address object from an dictionary
 *
 * @param NSDictionary *dictionary - associative dictionary of initial properties to set
 *
 * @return EventAddress
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (EventAddress *)eventAddressWithDictionary:(NSDictionary *)dictionary;

- (NSString*)JSON;

@end
