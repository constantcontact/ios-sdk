//
//  Schedule.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Component.h"
/**
 * Represents a campaign Schedule in Constant Contact
 *
 */
@interface Schedule : NSObject

/**
 * unique id of the schedule
 *
 * @var NSString
 */
@property (nonatomic, strong, readonly) NSString *scheduleId;

/**
 * The scheduled start date/time in ISO 8601 format
 *
 * @var NSString
 */
@property (nonatomic, strong) NSString *scheduledDate;

/**
 * Factory method to create a Schedule object from an dictionary
 *
 * @param Dictionary *dictionary - associative dictionary of initial properties to set
 *
 * @return Schedule *
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (Schedule *)scheduleWithDictionary:(NSDictionary *)dictionary;

/**
 * Create json used for a POST/PUT request, also handles removing attributes that will cause errors if sent
 *
 * @return NSString
 */
- (NSString*)JSON;
- (NSDictionary*)proxyForJSON;
@end
