//
//  AccountService.h
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OrganizationAddresses.h"
#import "AccountSummary.h"
#import "HttpResponse.h"
#import "HttpRequest.h"
#import "Config.h"

@interface AccountService : NSObject

/**
 * Retrieve the summary account-related information listed in the Structure section for the authorized Constant Contact account.
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 *
 * @return HttpResponse * - response containing data and errors (if there are some), data contains Account Summary type item
 */
+ (HttpResponse *)getAccountSummaryWithAccessToken:(NSString*)accessToken;


/**
 * Updates account-related information for the authorized Constant Contact account.
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param AccountSummary *summary - the Account Summary item that is about to be updated
 *
 @ return HttpResponse * - response containing data and errors (if there are some), data contains Account Summary type item
 */
+ (HttpResponse *)updateAccountSummaryWithAccesToken:(NSString *)accessToken andSummary:(AccountSummary *)summary;


@end
