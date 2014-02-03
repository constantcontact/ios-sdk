//
//  AllActivites.h
//  CTCTContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Component.h"

/**
 * Represents  a list of all activities for all campaigns for a specific contact.
 *
 */
@interface AllActivites : NSObject

@property (strong, nonatomic) NSString *contactId;
@property (strong, nonatomic) NSString *openDate;
@property (strong, nonatomic) NSString *unsubscribeDate;
@property (strong, nonatomic) NSString *sendDate;
@property (strong, nonatomic) NSString *forwardDate;
@property (readwrite, nonatomic) int   opens;
@property (strong, nonatomic) NSString *linkUri;
@property (strong, nonatomic) NSString *linkId;
@property (readwrite, nonatomic) int   bounces;
@property (strong, nonatomic) NSString *unsubscribeReason;
@property (strong, nonatomic) NSString *campaignId;
@property (readwrite, nonatomic) int   forwards;
@property (strong, nonatomic) NSString *bounceDescription;
@property (strong, nonatomic) NSString *unsubscribeSource;
@property (strong, nonatomic) NSString *bounceMessage;
@property (strong, nonatomic) NSString *bounceCode;
@property (readwrite, nonatomic) int   clicks;
@property (strong, nonatomic) NSString *bounceDate;
@property (strong, nonatomic) NSString *clickDate;
@property (strong, nonatomic) NSString *activityType;
@property (strong, nonatomic) NSString *emailAddress;

/**
 * Factory method to create a AllActivites object from an dictionary
 *
 * @param NSDictionary *dictionary - dictionary of properties to create object from
 *
 * @return AllActivites *
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (AllActivites *)allActivitesWithDictionary:(NSDictionary *)dictionary;

@end