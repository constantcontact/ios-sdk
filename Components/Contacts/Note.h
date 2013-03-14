//
//  Note.h
//  ConstantContact
//
//  Created by A_Dumitras on 2/22/13.
//  Copyright (c) 2013 Sergiu Grigoriev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Component.h"

/**
 * Represents a Contact Note
 *
 * @package     Components
 * @subpackage     Contacts
 * @author         Constant Contact
 */
@interface Note : NSObject
/**
 * Id of the note
 * @var string
 */
@property (nonatomic, readwrite) NSString *id;
/**
 * Content of the note
 * @var string
 */
@property (nonatomic, strong) NSString *note;
/**
 * Date the note was created
 * @var string
 */
@property (nonatomic, strong) NSString *createdDate;
/**
 * Factory method to create a Note object from an array
 * @param array $props - Associative array of initial properties to set
 * @return Note
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (Note *)NoteWithDictionary:(NSDictionary *)dictionary;
@end
