//
//  MessageFooter.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Component.h"

/**
 * Represents a click through detail
 *
 */
@interface MessageFooter : NSObject

@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *organizationMame;
@property (nonatomic, strong) NSString *addressLine1;
@property (nonatomic, strong) NSString *addressLine2;
@property (nonatomic, strong) NSString *addressLine3;
@property (nonatomic, strong) NSString *internationalState;
@property (nonatomic, strong) NSString *postalCode;
@property (nonatomic, readwrite) BOOL includeForwardEmail;
@property (nonatomic, strong) NSString *forwardEmailLinkText;
@property (nonatomic, readwrite) BOOL includeSubscribeLink;
@property (nonatomic, strong) NSString *subscribeLinkText;

/**
 * Factory method to create a MessageFooter object from an dictionary
 *
 * @param NSDictionary *dictionary - associative dictionary of initial properties to set
 *
 * @return MessageFooter
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (MessageFooter *)messageFooterWithDictionary:(NSDictionary *)dictionary;

- (NSString*)JSON;

@end
