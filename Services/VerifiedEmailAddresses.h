//
//  VeriffiedEmailAddresses.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EmailAddress.h"
#import "HttpRequest.h"
#import "Config.h"

@interface VerifiedEmailAddresses : NSObject
/**
 * Get a array of valid email addresses that can be used for some objects
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *status - the status of the email adresses that you want to get , either CONFIRMED or UNCONFIRMED
 *
 * @return HttpResponse * - response containing data and errors (if there are some)
 */

+ (HttpResponse *)getEmailAddresses:(NSString *)accessToken andConfirmedStatus:(NSString *)status;

@end
