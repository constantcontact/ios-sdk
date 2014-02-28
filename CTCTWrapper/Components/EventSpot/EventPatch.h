//
//  EventPatch.h
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EventPatchStatusEnum.h"
#import "EventPatchValueEnum.h"
#import "EventPatchOpEnum.h"

@interface EventPatch : NSObject

/**
 * The operation to perform values in EventPatchOpEnum class
 */
@property (nonatomic, strong) NSString *op;
/**
 * Where in the object to perform it , values in EventPatchOpEnum class
 */
@property (nonatomic, strong) NSString *path;
/**
 * The new value to write, values in EventPatchValueEnum class
 */
@property (nonatomic, strong) NSString *value;


/**
 * Enumeration class that contains valid options for event patch op (option) element
 */
@property (nonatomic, strong) EventPatchOpEnum *eventPatchOpEnum;

/**
 * Enumeration class that contains valid options for event patch path element
 */
@property (nonatomic, strong) EventPatchValueEnum *eventPatchValueEnum;

/**
 * Enumeration class that contains valid options for event patch status element
 */
@property (nonatomic, strong) EventPatchStatusEnum *eventPatchStatusEnum;


- (NSString*)JSON;

@end
