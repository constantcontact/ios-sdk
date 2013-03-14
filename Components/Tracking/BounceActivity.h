//
//  BounceActivity.h
//  ConstantContact
//
//  Copyright (c) 2013 Sergiu Grigoriev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Component.h"


/**
 * Represents a single Bounce Activity
 *
 */
@interface BounceActivity : NSObject

@property (nonatomic, strong) NSString * activityType;
@property (nonatomic, strong) NSString * bounceCode;
@property (nonatomic, strong) NSString * bounceDescription;
@property (nonatomic, strong) NSString * bounceMessage;
@property (nonatomic, strong) NSString * bounceDate;
@property (nonatomic, strong) NSString * contactId;
@property (nonatomic, strong) NSString * emailAddress;
@property (nonatomic, strong) NSString * campaignId;

/**
 * Factory method to create a BounceActivity object from an dictionary
 *
 * @param NSDictionary *dictionary - dictionary of properties to create object from
 *
 * @return BounceActivity
 */

- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (BounceActivity *)bounceActivityWithDictionary:(NSDictionary *)dictionary;

@end
