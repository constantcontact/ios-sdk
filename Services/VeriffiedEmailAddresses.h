//
//  VeriffiedEmailAddresses.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequest.h"
#import "Config.h"

@interface VeriffiedEmailAddresses : NSObject
/**
 * Get a array of valid email addresses that can be used for some objects
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *status - the status of the email adresses that you want to get , either CONFIRMED or UNCONFIRMED
 *
 * @return NSDictionary * -dictionary containing either @"ERROR" or @"data" with a array containing all the CONFIRMED or UNCONFIRMED email addresses
 */

+ (NSDictionary *)getEmailAddresses:(NSString *)accessToken andConfirmedStatus:(NSString *)status;

@end
