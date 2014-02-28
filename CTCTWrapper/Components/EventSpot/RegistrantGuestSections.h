//
//  RegistrantGuestSections.h
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RegistrantSectionField.h"
#import "Component.h"

@interface RegistrantGuestSections : NSObject

/**
 * The label of the guest section
 */
@property (nonatomic, strong) NSString *label;
/**
 * Section field array of a specific guest;
 */
@property (nonatomic, strong) NSMutableArray *sectionFields;

/**
 * Factory method to create a registrant guest section object from an dictionary
 *
 * @param NSDictionary *dictionary - associative dictionary of initial properties to set
 *
 * @return RegistrantGuestSections
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (RegistrantGuestSections *)registrantGuestSectionsWithDictionary:(NSDictionary *)dictionary;

- (NSString*)JSON;

@end
