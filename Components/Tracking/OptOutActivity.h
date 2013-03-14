//
//  OptOutActivity.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Represents a single Opt Out Activity
 *
 */
@interface OptOutActivity : NSObject

@property (nonatomic, strong) NSString *activityType;
@property (nonatomic, strong) NSString *campaignId;
@property (nonatomic, strong) NSString *contactId;
@property (nonatomic, strong) NSString *emailAddress;
@property (nonatomic, strong) NSString *unsubscribeDate;
@property (nonatomic, strong) NSString *unsubscribeSource;
@property (nonatomic, strong) NSString *unsubscribeReason;

/**
 * Factory method to create an OptOutActivity object from an dictionary
 *
 * @param NSDictionary *dictionary - dictionary of properties to create object from
 *
 * @return ClickActivity
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (OptOutActivity *)optOutWithDictionary:(NSDictionary *)dictionary;

@end
