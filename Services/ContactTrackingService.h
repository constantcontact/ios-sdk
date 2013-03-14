//
//  ContactTrackingService.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequest.h"
#import "Config.h"
#import "BounceActivity.h"
#import "TrackingActivity.h"
#import "ClickActivity.h"
#import "ForwardActivity.h"
#import "OpenActivity.h"
#import "OptOutActivity.h"
#import "SendActivity.h"
#import "TrackingSummary.h"
#import "ResultSet.h"

/**
 * Performs all actions pertaining to Contact Tracking
 *
 */
@interface ContactTrackingService : NSObject

/**
 * Get bounces for a given contact
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *contactId - id of the contact to which we want to see the tracking service
 * @param NSString *param - query param to be appended to request
 *
 * @return ResultSet *- Containing a results array of BounceActivityes
 */
+ (NSDictionary *)getBouncesWithAccessToken:(NSString *)accessToken contactId:(NSString *)contactId andParams:(NSString *)params;
/**
 * Get clicks for a given contact
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *contactId - id of the contact to which we want to see the tracking service
 * @param NSString *param - query param to be appended to request
 *
 * @return NSDictionary * -dictionary containing either @"ERROR" or @"data" with a ResultSet of ClickActivityes
 */
+ (NSDictionary *)getClicksWithAccessToken:(NSString *)accessToken contactId:(NSString *)contactId andParams:(NSString *)params;
/**
 * Get forwards for a given contact
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *contactId - id of the contact to which we want to see the tracking service
 * @param NSString *param - query param to be appended to request
 *
 * @return NSDictionary * -dictionary containing either @"ERROR" or @"data" with a ResultSet of ForwardActivityes
 */
+ (NSDictionary *)getForwardsWithAccessToken:(NSString *)accessToken contactId:(NSString *)contactId andParams:(NSString *)params;
/**
 * Get opens for a given contact
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *contactId - id of the contact to which we want to see the tracking service
 * @param NSString *param - query param to be appended to request
 *
 * @return NSDictionary * -dictionary containing either @"ERROR" or @"data" with a ResultSet of OpenActivityes
 */
+ (NSDictionary *)getOpensWithAccessToken:(NSString *)accessToken contactId:(NSString *)contactId andParams:(NSString *)params;
/**
 * Get sends for a given contact
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *contactId - id of the contact to which we want to see the tracking service
 * @param NSString *param - query param to be appended to request
 *
 * @return NSDictionary * -dictionary containing either @"ERROR" or @"data" with a ResultSet of SendActivityes
 */

+ (NSDictionary *)getSendsWithAccessToken:(NSString *)accessToken contactId:(NSString *)contactId andParams:(NSString *)params;
/**
 * Get opt outs for a given contact
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *contactId - id of the contact to which we want to see the tracking service
 * @param NSString *param - query param to be appended to request
 *
 * @return NSDictionary * -dictionary containing either @"ERROR" or @"data" with a ResultSet of OptOutActivityes
 */
+ (NSDictionary *)getOptOutsWithAccessToken:(NSString *)accessToken contactId:(NSString *)contactId andParams:(NSString *)params;
/**
 * Get a summary of reporting data for a given contact
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *contactId - id of the contact to which we want to see the tracking service
 *
 * @return NSDictionary * -dictionary containing either @"ERROR" or @"data" with a summary reguarding all activites of a specific contact
 */
+ (NSDictionary *)getSummaryWithAccessToken:(NSString *)accessToken contactId:(NSString *)contactId;

@end
