//
//  EventItem.h
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EventItemAttribute.h"
#import "Component.h"

@interface EventItem : NSObject

/**
 * An array of item attributes and options, add attributes after the item is created
 */
@property (nonatomic, strong, readonly) NSMutableArray *attributes;
/**
 * Number of items available for sale, displayed on the registration page if show_quantity_available = true.
 */
@property (nonatomic, readonly) int defaultQuantityAvailable;
/**
 * REQUIRED. The total quantity of items offered, minimum = 0, cannot leave blank. If the item has attributes, the summation of the quantity_total for all attributes automatically overwrites the value you enter here.
 */
@property (nonatomic, readwrite) int defaultQuantityTotal;
/**
 * The item description shown on the registration page
 */
@property (nonatomic, strong) NSString *description;
/**
 * Unique ID of the item
 */
@property (nonatomic, strong,readonly) NSString *eventItemId;
/**
 * REQUIRED. Name of the item shown on the registration page, minimum length = 1.
 */
@property (nonatomic, strong) NSString *name;
/**
 * REQUIRED. The maximum number of this item that registrants and guests can purchase, minimum = 0, cannot leave blank; value cannot be greater than the value of default_quantity_available
 */
@property (nonatomic, readwrite) int perRegistrantLimit;
/**
 * REQUIRED. The item cost, minimum = 0.00
 */
@property (nonatomic, readwrite) double price;
/**
 * If true, displays the remaining quantity of this item for purchase on the registration page
 */
@property (nonatomic, readwrite) BOOL showQuantityAvailable;

/**
 * Factory method to create a Event Item object from an dictionary
 *
 * @param NSDictionary *dictionary - associative dictionary of initial properties to set
 *
 * @return EventItem
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (EventItem *)eventItemWithDictionary:(NSDictionary *)dictionary;

- (NSString*)JSON;

@end
