//
//  EmailSortedActivity.h
//  CTCTContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Component.h"

/**
 * Represents a report of a contact's activities for all email campaigns sent to them
 *
 */
@interface EmailSortedActivity : NSObject

@property (nonatomic, strong) NSString *contactId;
@property (nonatomic, readwrite) int   clicks;
@property (nonatomic, readwrite) int   opens;
@property (nonatomic, readwrite) int   bounces;
@property (nonatomic, readwrite) int   forwards;
@property (nonatomic, strong) NSString *campaignId;


/**
 * Factory method to create a EmailSortedActivity object from an dictionary
 *
 * @param NSDictionary *dictionary - dictionary of properties to create object from
 *
 * @return EmailSortedActivity *
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (EmailSortedActivity *)emailSortedActivityWithDictionary:(NSDictionary *)dictionary;


@end
