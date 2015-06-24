//
//  AccountSummary.h
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OrganizationAddresses.h"
#import "Component.h"

@interface AccountSummary : NSObject

/**
 * URL to the logo associated with the account if the account owner has provided one. No value is returned if user has not added a logo.
 */
@property (nonatomic, strong) NSString *companyLogo;
/**
 * Standard 2 letter ISO 3166-1 code of the country associated with the account owner
 */
@property (nonatomic, strong) NSString *countryCode;
/**
 * Email address associated with the account owner
 */
@property (nonatomic, strong) NSString *email;
/**
 * The account owner's first name
 */
@property (nonatomic, strong) NSString *firstName;
/**
 * The account owner's last name
 */
@property (nonatomic, strong) NSString *lastName;
/**
 * An array of organization street addresses; currently, only a single address is supported. This is not a required attribute, but if you include organization_addresses in a put, it must include the country_code, city, and line1 fields at minimum.
 */
@property (nonatomic, strong) NSMutableArray *organizationAddresses;
/**
 * Name of the organization associated with the account
 */
@property (nonatomic, strong) NSString *organizationName;
/**
 * Phone number associated with the account owner.
 */
@property (nonatomic, strong) NSString *phone;
/**
 * 2 letter code for USA state or Canadian province ONLY, available only if country_code = US or CA associated with the account owner
 */
@property (nonatomic, strong) NSString *stateCode;
/**
 * The time zone associated with the account
 */
@property (nonatomic, strong, readonly) NSString *timeZone;
/**
 * The URL of the Web site associated with the account
 */
@property (nonatomic, strong) NSString *website;

/**
 * Factory method to retrieve a Account Summary object from an dictionary
 *
 * @param NSDictionary *dictionary - associative dictionary of initial properties to set
 *
 * @return AccountSummary
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (AccountSummary *)accountSummaryWithDictionary:(NSDictionary *)dictionary;

- (NSString*)JSON;


@end
