//
//  RegistrantGuestInfo.h
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RegistrantGuestSections.h"
#import "Component.h"

@interface RegistrantGuestInfo : NSObject

/**
 * The unique ID of each guest
 */
@property (nonatomic, strong) NSString *guestId;
/**
 * A RegistrantGuestSections item containing the properties of a specific guest
 */
@property (nonatomic, strong) RegistrantGuestSections *guestSections;

/**
 * Factory method to create a Registrant guest info object from an dictionary
 *
 * @param NSDictionary *dictionary - associative dictionary of initial properties to set
 *
 * @return RegistrantGuestInfo
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (RegistrantGuestInfo *)registrantGuestInfoWithDictionary:(NSDictionary *)dictionary;

- (NSString*)JSON;

@end
