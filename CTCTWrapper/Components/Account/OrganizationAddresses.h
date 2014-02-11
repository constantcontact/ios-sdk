//
//  OrganizationAddresses.h
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Component.h"

@interface OrganizationAddresses : NSObject

/**
 * REQUIRED if including organization_addresses; The city the organization is located in
 */
@property (nonatomic, strong) NSString *city;
/**
 * REQUIRED if including organization_addresses; Standard 2 letter ISO 3166-1 code for the organization_addresses
 */
@property (nonatomic, strong) NSString *countryCode;
/**
 * Line 1 of the organization's street address
 */
@property (nonatomic, strong) NSString *line1;
/**
 * Line 2 of the organization's street address
 */
@property (nonatomic, strong) NSString *line2;
/**
 * Line 3 of the organization's street address
 */
@property (nonatomic, strong) NSString *line3;
/**
 * Postal (zip) code of the organization's street address
 */
@property (nonatomic, strong) NSString *postalCode;
/**
 * Name of the state or province for the organization_addresses; for country = CA or US, this field is overwritten by the state or province name derived from the state_code, if entered.
 */
@property (nonatomic, strong) NSString *state;
/**
 * Use ONLY for the standard 2 letter abbreviation for the US state or Canadian province for organization_addresses; NOTE: A data validation error occurs if state_code is populated and country_code does not = US or CA.
 */
@property (nonatomic, strong) NSString *stateCode;

/**
 * Factory method to retrieve a Organization Addresses object from an dictionary
 *
 * @param NSDictionary *dictionary - associative dictionary of initial properties to set
 *
 * @return OrganizationAddresses
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (OrganizationAddresses *)organizationAddressWithDictionary:(NSDictionary *)dictionary;

- (NSString*)JSON;

@end
