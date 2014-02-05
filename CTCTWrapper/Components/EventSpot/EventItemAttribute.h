//
//  EventItemAttribute.h
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Component.h"

@interface EventItemAttribute : NSObject

/**
 * The attribute's Unique ID 
 */
@property (nonatomic, strong, readonly) NSString *itemAttributeId;
/**
 * REQUIRED. Attribute name, minimum length = 1, cannot leave blank
 */
@property (nonatomic, strong) NSString *name;
 /**
 * Number of item attributes that are still available
 */
@property (nonatomic, readonly) int quantityAvailable;
/**
 * REQUIRED. Number of item attributes offered, minimum = 0, cannot leave blank
 */
@property (nonatomic, readwrite) int quantityTotal;

/**
 * Factory method to create a Item Attribute object from an dictionary
 *
 * @param NSDictionary *dictionary - associative dictionary of initial properties to set
 *
 * @return EventItemAttribute
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (EventItemAttribute *)itemAttributeWithDictionary:(NSDictionary *)dictionary;

- (NSString*)JSON;

@end
