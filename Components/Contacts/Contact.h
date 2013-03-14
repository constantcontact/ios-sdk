//
//  Contact.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Address.h"
#import "ContactList.h"
#import "EmailAddress.h"
#import "CustomField.h"
#import "Component.h"

@interface Contact : NSObject

@property (nonatomic, strong) NSMutableArray *addresses;
@property (nonatomic, strong) NSString *cellPhone;
@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSMutableArray *customFields;
@property (nonatomic, strong) NSMutableArray *emailAddresses;
@property (nonatomic, strong) NSString *fax;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *homePhone;
@property (nonatomic, readwrite) int id;
@property (nonatomic, strong) NSString *jobTitle;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *lastUpdateDate;
@property (nonatomic, strong) NSMutableArray *lists;
@property (nonatomic, strong) NSString *middleName;
@property (nonatomic, strong) NSString *prefixName;
@property (nonatomic, strong) NSString *sourceDetails;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *workPhone;

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (void) addList:(ContactList*)contactList;
- (void) addEmailAddress:(EmailAddress*)emailAddress;
- (void) addAddress:(Address*)address;
- (NSString *) toJson;
- (NSString *) toJsonForContact;


+(Contact*)contactWithDictionary:(NSDictionary *)dictionary;
@end
