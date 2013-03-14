//
//  ForwardActivity.h
//  ConstantContact
//
//  Copyright (c) 2013 Sergiu Grigoriev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Component.h"

/**
 * Represents a Forward Activity
 *
 */
@interface ForwardActivity : NSObject

@property (nonatomic, strong) NSString *activityType;
@property (nonatomic, strong) NSString *contactId;
@property (nonatomic, strong) NSString *emailAddress;
@property (nonatomic, strong) NSString *forwardDate;
@property (nonatomic, strong) NSString *campaignId;

/**
 * Factory method to create a ForwardActivity object from an dictionary
 *
 * @param NSDictionary *dictionary - dictionary of properties to create object from
 *
 * @return ClickActivity *
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (ForwardActivity *)forwardActivityWithDictionary:(NSDictionary *)dictionary;

@end
