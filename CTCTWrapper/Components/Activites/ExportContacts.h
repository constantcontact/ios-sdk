//
//  ExportContacts.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Component.h"

/**
 * Represents an Export Contacts Activity in Constant Contact
 *
 */
@interface ExportContacts : NSObject

@property (nonatomic, strong) NSString *fileType;
@property (nonatomic, strong) NSString *sortBy; 
@property (nonatomic, readwrite) BOOL exportDateAdded;
@property (nonatomic, readwrite) BOOL exportAddedBy;
@property (nonatomic, strong) NSMutableArray *lists;
@property (nonatomic, strong) NSMutableArray *columnNames;

/**
 * Constructor
 *
 * @param NSArray *lists - array of list id's to export from
 *
 * @return ExportContacts
 */
- (id)initWithListsArray:(NSArray *)lists;

/**
 * Create json used for a POST/PUT request, also handles removing attributes that will cause errors if sent
 *
 * @return string
 */
- (NSString *) toJson;

@end
