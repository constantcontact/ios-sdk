//
//  EventContact.h
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Component.h"

@interface EventContact : NSObject

/**
 * Event contact's email-address
 */
@property (nonatomic, strong) NSString *emailAddress;
/**
 * REQUIRED. Name of the person conducting or managing the event
 */
@property (nonatomic, strong) NSString *name;
/**
 * Event contact's organization name
 */
@property (nonatomic, strong) NSString *organizationName;
/**
 * Event contact's phone number
 */
@property (nonatomic, strong) NSString *phoneNumber;

/**
 * Factory method to create a Event Contact object from an dictionary
 *
 * @param NSDictionary *dictionary - associative dictionary of initial properties to set
 *
 * @return EventContact
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (EventContact *)eventContactWithDictionary:(NSDictionary *)dictionary;

- (NSString*)JSON;

@end
