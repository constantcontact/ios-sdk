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
#import "AllActivites.h"
#import "EmailSortedActivity.h"

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
 * @return HttpResponse *-  response containing a results array of BounceActivityes
 */
+ (HttpResponse*)getBouncesWithAccessToken:(NSString *)accessToken contactId:(NSString *)contactId andParams:(NSString *)params;
/**
 * Get clicks for a given contact
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *contactId - id of the contact to which we want to see the tracking service
 * @param NSString *param - query param to be appended to request
 *
 * @return HttpResponse * - response containing either @"ERROR" or @"data" with a ResultSet of ClickActivityes
 */
+ (HttpResponse*)getClicksWithAccessToken:(NSString *)accessToken contactId:(NSString *)contactId andParams:(NSString *)params;
/**
 * Get forwards for a given contact
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *contactId - id of the contact to which we want to see the tracking service
 * @param NSString *param - query param to be appended to request
 *
 * @return HttpResponse * - response containing either @"ERROR" or @"data" with a ResultSet of ForwardActivityes
 */
+ (HttpResponse*)getForwardsWithAccessToken:(NSString *)accessToken contactId:(NSString *)contactId andParams:(NSString *)params;
/**
 * Get opens for a given contact
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *contactId - id of the contact to which we want to see the tracking service
 * @param NSString *param - query param to be appended to request
 *
 * @return HttpResponse * - response containing either @"ERROR" or @"data" with a ResultSet of OpenActivityes
 */
+ (HttpResponse*)getOpensWithAccessToken:(NSString *)accessToken contactId:(NSString *)contactId andParams:(NSString *)params;
/**
 * Get sends for a given contact
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *contactId - id of the contact to which we want to see the tracking service
 * @param NSString *param - query param to be appended to request
 *
 * @return HttpResponse * - response containing either @"ERROR" or @"data" with a ResultSet of SendActivityes
 */

+ (HttpResponse*)getSendsWithAccessToken:(NSString *)accessToken contactId:(NSString *)contactId andParams:(NSString *)params;
/**
 * Get opt outs for a given contact
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *contactId - id of the contact to which we want to see the tracking service
 * @param NSString *param - query param to be appended to request
 *
 * @return HttpResponse * - response containing either @"ERROR" or @"data" with a ResultSet of OptOutActivityes
 */
+ (HttpResponse*)getOptOutsWithAccessToken:(NSString *)accessToken contactId:(NSString *)contactId andParams:(NSString *)params;
/**
 * Get a summary of reporting data for a given contact
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *contactId - id of the contact to which we want to see the tracking service
 *
 * @return HttpResponse * - response containing either @"ERROR" or @"data" with a summary reguarding all activites of a specific contact
 */
+ (HttpResponse*)getSummaryWithAccessToken:(NSString *)accessToken contactId:(NSString *)contactId;

/**
 * Get all the activites of the user sorted by email campaign
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *contactId - id of the contact to which we want to see the tracking service
 * @param NSstring *limit - (optional) the number of elements returned on one page;
 *
 * @return HttpResponse * - response containing either @"ERROR" or @"data" with the activites of the user sorted by email campaign
 */
+ (HttpResponse*)getActivitesSortedByEmailCampaignWithAccessToken:(NSString *)accessToken contactId:(NSString *)contactId andALimitOf:(NSString *)limit;

/**
 * Get all e activites of the user
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *contactId - id of the contact to which we want to see the tracking service
 * @param NSstring *limit - (optional) the number of elements returned on one page;
 *
 * @return HttpResponse * - response containing either @"ERROR" or @"data" with the activites of the user
 */
+ (HttpResponse*)getAllContactActivitesWithAccessToken:(NSString *)accessToken contactId:(NSString *)contactId andALimitOf:(NSString *)limit;
@end
