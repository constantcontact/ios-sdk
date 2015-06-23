//
//  AddContactsImportData.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Component.h"
#import "Address.h"
#import "Contact.h"
#import "CustomField.h"

/**
 * Represents a single Activity in Constant Contact
 *
 */
@interface AddContactsImportData : NSObject


@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *middleName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *jobTitle;
@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSString *workPhone;
@property (nonatomic, strong) NSString *homePhone;
@property (nonatomic, strong) NSString *birthdayDay;
@property (nonatomic, strong) NSString *birthdayMonth;
@property (nonatomic, strong) NSDate *aniversary;

@property (nonatomic, strong) NSMutableArray *emailAddresses;
@property (nonatomic, strong) NSMutableArray *addresses;
@property (nonatomic, strong) NSMutableArray *customFields;

/**
 * Factory method to create an Activity object from an dictionary
 *
 * @param NSDictionary *dictionary - associative dictionary of initial properties to set
 *
 * @return Campaign
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (AddContactsImportData *)AddContactsImportDatarWithDictionary:(NSDictionary *)dictionary;

- (void)addEmail:(EmailAddress *)emailAddress;
- (void)addAddress:(Address *)address;
- (void)addCustomField:(CustomField *)customField;

- (id) proxyForJson;
- (NSString *) toJson;

@end
