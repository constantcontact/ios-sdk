//
//  OpenActivity.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Component.h"

/**
 * Represents an Open Activity
 *
 */
@interface OpenActivity : NSObject

@property (nonatomic, strong) NSString *activityType;
@property (nonatomic, strong) NSString *contactId;
@property (nonatomic, strong) NSString *emailAddress;
@property (nonatomic, strong) NSString *openDate;
@property (nonatomic, strong) NSString *campaignId;
    
/**
* Factory method to create a OpenActivity object from an directory
 *
 * @param NSDictionary *dictionary - dictionary of properties to create object from
 *
* @return OpenActivity
*/
- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (OpenActivity *)openActivityWithDictionary:(NSDictionary *)dictionary;

@end
