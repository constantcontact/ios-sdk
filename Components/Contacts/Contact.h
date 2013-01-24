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

@property (nonatomic, assign) NSString *actionBy;
@property (nonatomic, strong) NSMutableArray *addresses;
@property (nonatomic, assign) NSString *cellPhone;
@property (nonatomic, assign) NSString *companyName;
@property (nonatomic, strong) NSMutableArray *customFields;
@property (nonatomic, assign) NSString *departmentName;
@property (nonatomic, strong) NSMutableArray *emailAddresses;
@property (nonatomic, assign) NSString *fax;
@property (nonatomic, assign) NSString *firstName;
@property (nonatomic, assign) NSString *homePhone;
@property (nonatomic, assign) int id;
@property (nonatomic, assign) NSString *jobTitle;
@property (nonatomic, assign) NSString *lastName;
@property (nonatomic, assign) NSString *lastUpdateTime;
@property (nonatomic, strong) NSMutableArray *lists;
@property (nonatomic, assign) NSString *middleName;
@property (nonatomic, assign) NSString *prefixName;
@property (nonatomic, assign) NSString *sourceDetails;
@property (nonatomic, assign) BOOL sourceIsUrl;
@property (nonatomic, assign) NSString *status;
@property (nonatomic, assign) NSString *webUrl;
@property (nonatomic, assign) NSString *workPhone;

-(id)initWithDictionary:(NSDictionary *)dictionary;
-(void) addList:(ContactList*)contactList;
-(void) addEmailAddress:(EmailAddress*)emailAddress;
-(void) addAddress:(Address*)address;
-(NSString*) toJson;


+(Contact*)contactWithDictionary:(NSDictionary *)dictionary;
@end
