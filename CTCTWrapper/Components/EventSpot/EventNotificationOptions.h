//
//  EventNotificationOptions.h
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Component.h"

@interface EventNotificationOptions : NSObject

/**
 * Set to true to send event notifications to the contact email_address, false for no notifications; Default is false
 */
@property (nonatomic, readwrite) BOOL isOptedIn;
/**
 * Specifies the type of notifications sent to the contact email_address, valid values: SO_REGISTRATION_NOTIFICATION - send notice for each registration (Default)
 */
@property (nonatomic, strong) NSString *notificationType;

/**
 * Factory method to create a Event Notification Options object from an dictionary
 *
 * @param NSDictionary *dictionary - associative dictionary of initial properties to set
 *
 * @return EventNotificationOptions
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (EventNotificationOptions *)eventNotificationWithDictionary:(NSDictionary *)dictionary;

- (NSString*)JSON;

@end
