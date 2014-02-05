//
//  RegistrantSectionField.h
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Component.h"

@interface RegistrantSectionField : NSObject

/**
 * Field type
 */
@property (nonatomic, strong) NSString *type;
/**
 * Field name
 */
@property (nonatomic, strong) NSString *name;
/**
 * Field label
 */
@property (nonatomic, strong) NSString *label;
/**
 * Field value
 */
@property (nonatomic, strong) NSString *value;

/**
 * Factory method to create a registrant section field object from an dictionary
 *
 * @param NSDictionary *dictionary - associative dictionary of initial properties to set
 *
 * @return RegistrantSectionField
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (RegistrantSectionField *)sectionFieldWithDictionary:(NSDictionary *)dictionary;

- (NSString*)JSON;

@end
