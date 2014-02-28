//
//  RegistrantGuest.h
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RegistrantGuestInfo.h"
#import "Component.h"

@interface RegistrantGuest : NSObject

/**
 * Total number of guests
 */
@property (nonatomic, readwrite) int guestCount;
/**
 * Array of RegistrantGuestInfo elements
 */
@property (nonatomic, strong) NSMutableArray *guestsInfo;

/**
 * Factory method to create a Registrant guest object from an dictionary
 *
 * @param NSDictionary *dictionary - associative dictionary of initial properties to set
 *
 * @return RegistrantGuest
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (RegistrantGuest *)registrantGuestWithDictionary:(NSDictionary *)dictionary;

- (NSString*)JSON;

@end
