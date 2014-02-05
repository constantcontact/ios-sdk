//
//  EventOnlineMeeting.h
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Component.h"

@interface EventOnlineMeeting : NSObject

/**
 * Online meeting instructions, such as dial in number, password, etc
 */
@property (nonatomic, strong) NSString *instructions;
/**
 * Meeting ID, if any, for the meeting
 */
@property (nonatomic, strong) NSString *providerMeetingId;
/**
 * Specify the online meeting provider, such as WebEx
 */
@property (nonatomic, strong) NSString *providerType;
/**
 * URL for online meeting. REQUIRED if is_virtual_event is set to true.
 */
@property (nonatomic, strong) NSString *url;

/**
 * Factory method to create a Event Online Meeting object from an dictionary
 *
 * @param NSDictionary *dictionary - associative dictionary of initial properties to set
 *
 * @return EventOnlineMeeting
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (EventOnlineMeeting *)eventOnlineMeetingWithDictionary:(NSDictionary *)dictionary;

- (NSString*)JSON;

@end
