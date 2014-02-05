//
//  RegistrantSection.h
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EventRegistrantSectionsFieldTypeEnum.h"
#import "RegistrantSectionField.h"
#import "Component.h"

@interface RegistrantSection : NSObject

/**
 * Type of the value; valid values are found in EventRegistrantSectionsFieldTypeEnum class
 */
@property (nonatomic, strong) NSString *fieldType;
/**
 * Field value if type = single_value
 */
@property (nonatomic, strong) NSMutableArray *values;
/**
 * Name of the field
 */
@property (nonatomic, strong) NSString *name;
/**
 * An array of field values if type = multiple_values
 */
@property (nonatomic, strong) NSString *value;
/**
 * Field label displayed to viewers
 */
@property (nonatomic, strong) NSString *label;
/**
 * An array of the fields displayed in a section
 */
@property (nonatomic, strong) NSMutableArray *fields;

/**
 * Enumeration class that contains valid options for section field type element
 */
@property (nonatomic, strong, readonly) EventRegistrantSectionsFieldTypeEnum *eventRegistrantSectionsFieldTypeEnum;

/**
 * Factory method to create a Registrant section object from an dictionary
 *
 * @param NSDictionary *dictionary - associative dictionary of initial properties to set
 *
 * @return RegistrantSection
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (RegistrantSection *)registrantSectionWithDictionary:(NSDictionary *)dictionary;

- (NSString*)JSON;

@end
