//
//  SendActivity.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Component.h"

/**
 * Represents a Sent Activity
 *
 */
@interface SendActivity : NSObject

@property (nonatomic, strong) NSString *activityType;
@property (nonatomic, strong) NSString *sendDate;
@property (nonatomic, strong) NSString *contactId;
@property (nonatomic, strong) NSString *emailAddress;
@property (nonatomic, strong) NSString *campaignId;

/**
 * Factory method to create a SentActivity object from an dictionary
 *
 * @param NSDictionary *dictionary - dictionary of properties to create object from
 *
 * @return SentActivity * 
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (SendActivity *)sendActivityWithDictionary:(NSDictionary *)dictionary;

@end
