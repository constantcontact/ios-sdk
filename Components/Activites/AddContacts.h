//
//  AddContacts.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Component.h"
#import "Config.h"
#import "ActivityError.h"
#import "AddContactsImportData.h"

/**
 * Represents an AddContact activity
 *
 */
@interface AddContacts : NSObject

@property (nonatomic, strong) NSArray *importData;
@property (nonatomic, strong) NSArray *lists;
@property (nonatomic, strong) NSArray *columnNames;

- (id)initWithContactsArray:(NSArray *)contacts andLists:(NSArray *)lists andColumnNames:(NSArray *)columnNames;

- (NSString *) toJson;

@end
