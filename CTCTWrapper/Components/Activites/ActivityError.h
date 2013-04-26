//
//  ActivityError.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Activity.h"

@interface ActivityError : NSObject

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *lineNumber;
@property (nonatomic, strong) NSString *emailAddress;

/**
 * Factory method to create an  object from an dictionary
 *
 * @param NSDictionary *dictionary - dictionary of initial properties to set
 *
 * @return Campaign
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (ActivityError *)activityErrorWithDictionary:(NSDictionary *)dictionary;

@end
