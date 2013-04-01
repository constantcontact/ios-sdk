//
//  Activity.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Component.h"

/**
 * Represents a single Activity in Constant Contact
 *
 */
@interface Activity : NSObject

@property (nonatomic, strong, readonly) NSString *activityId;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *startDate;
@property (nonatomic, strong) NSString *finishDate;
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSString *createdDate;
@property (nonatomic, strong) NSString *errorCount;
@property (nonatomic, strong) NSString *contactCount;

@property (nonatomic, strong) NSMutableArray *errors;
@property (nonatomic, strong) NSMutableArray *warnings;

/**
 * Factory method to create an Activity object from an dictionary
 *
 * @param NSDictionary *dictionary - dictionary with propertyes to set
 *
 * @return Activity
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (Activity *)activityWithDictionary:(NSDictionary *)dictionary;

/**
 * Create jsonDict used for a POST/PUT request, also handles removing attributes that will cause errors if sent
 *
 * @return NSMutableDictionary - dictionary that can be used to create json, or can be added in another json string
 */
-(id) proxyForJson;
@end
