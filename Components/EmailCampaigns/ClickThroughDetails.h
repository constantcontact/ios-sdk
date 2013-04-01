//
//  ClickThroughDetails.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Component.h"

/**
 * Represents a single Campaign in Constant Contact
 *
 */
@interface ClickThroughDetails : NSObject
/**
 * the actual url that was clicked on
 *
 * @var NSString
 */
@property (nonatomic, strong) NSString *url;
/**
 * url unique identifier
 *
 * @var NSString
 */
@property (nonatomic, strong) NSString *urlUid;
/**
 * number of times the url was clicked on
 *
 * @var int
 */
@property (nonatomic, readwrite) int clickCount;

/**
 * Factory method to create a ClickThroughDetails object from an dictionary
 *
 * @param NSDictionary * dictionary - associative dictionary of initial properties to set
 *
 * @return ClickThroughDetails *
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (ClickThroughDetails *)clickThroughDetailsWithDictionary:(NSDictionary *)dictionary;

@end
