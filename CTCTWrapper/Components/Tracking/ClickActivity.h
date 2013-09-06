//
//  ClickActivity.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Component.h"

/**
 * Represents a Click Activity
 *
 */
@interface ClickActivity : NSObject

@property (nonatomic, strong) NSString *activityType;
@property (nonatomic, strong) NSString *contactId;
@property (nonatomic, strong) NSString *emailAddress;
@property (nonatomic, strong) NSString *linkId;
@property (nonatomic, strong) NSString *clickDate;
@property (nonatomic, strong) NSString *campaignId;


/**
 * Factory method to create a ClickActivity object from an dictionary
 *
 * @param NSDictionary *dictionary - dictionary of properties to create object from
 *
 * @return ClickActivity *
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (ClickActivity *)clickActivityWithDictionary:(NSDictionary *)dictionary;

@end
