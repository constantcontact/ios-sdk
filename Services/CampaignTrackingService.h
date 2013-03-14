//
//  CampaignTrackingService.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
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
#import "HttpRequest.h"

/**
 * Performs all actions pertaining to Constant Contact Campaign Tracking
 *
 */
@interface CampaignTrackingService : NSObject
/**
 * Get a result set of bounces for a given campaign
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *campaignId - id of the Campaign to which we want to see the tracking service
 * @param NSString *param - query param to be appended to request
 *
 * @return NSDictionary * -dictionary containing either @"ERROR" or @"data" with a ResultsSet of BounceActivityes
 */
+ (NSDictionary *)getBouncesWithAccessToken:(NSString *)accessToken campaignID:(NSString *)campaignId andParams:(NSString *)params;

/**
 * Get clicks for a given campaign
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *campaignId - id of the Campaign to which we want to see the tracking service
 * @param NSString *param - query param to be appended to request
 *
 * @return NSDictionary * -dictionary containing either @"ERROR" or @"data" with a ResultSet of ClickActivityes
 */
+ (NSDictionary *)getClicksWithAccessToken:(NSString *)accessToken campaignId:(NSString *)campaignId andParams:(NSString *)params;

/**
 * Get forwards for a given campaign
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *campaignId - id of the Campaign to which we want to see the tracking service
 * @param NSString *param - query param to be appended to request
 *
 * @return NSDictionary * -dictionary containing either @"ERROR" or @"data" with a ResultSet of ForwardActivityes
 */

+ (NSDictionary *)getForwardsWithAccessToken:(NSString *)accessToken campaignId:(NSString *)campaignId andParams:(NSString *)params;

/**
 * Get opens for a given campaign
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *campaignId - id of the Campaign to which we want to see the tracking service
 * @param NSString *param - query param to be appended to request
 *
 * @return NSDictionary * -dictionary containing either @"ERROR" or @"data" with a ResultSet of OpenActivityes
 */
+ (NSDictionary *)getOpensWithAccessToken:(NSString *)accessToken campaignId:(NSString *)campaignId andParams:(NSString *)params;

/**
 * Get sends for a given campaign
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *campaignId - id of the Campaign to which we want to see the tracking service
 * @param NSString *param - query param to be appended to request
 *
 * @return NSDictionary * -dictionary containing either @"ERROR" or @"data" with a ResultSet of SendActivityes
 */
+ (NSDictionary *)getSendsWithAccessToken:(NSString *)accessToken campaignId:(NSString *)campaignId andParams:(NSString *)params;

/**
 * Get opt outs for a given campaign
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *campaignId - id of the Campaign to which we want to see the tracking service
 * @param NSString *param - query param to be appended to request
 *
 * @return NSDictionary * -dictionary containing either @"ERROR" or @"data" with a ResultSet of OptOutActivityes;
 */
+ (NSDictionary *)getOptOutsWithAccessToken:(NSString *)accessToken campaignId:(NSString *)campaignId andParams:(NSString *)params;

/**
 * Get clicks for a specific link for a given campaign
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *campaignId - id of the Campaign to which we want to see the tracking service
 * @param NSString *param - query param to be appended to request
 * @param NSString *linkId - the id of the specific link you want
 *
 * @return NSDictionary * -dictionary containing either @"ERROR" or @"data" with a ResultSet of all the Clicks on a specific link;
 */
+ (NSDictionary *)getClicksByLinkwithAccessToken:(NSString *)accessToken campaignId:(NSString *)campaignId linkId:(NSString *)linkId andParams:(NSString *)params;

/**
 * Get a summary of reporting data for a given campaign
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *campaignId - id of the Campaign to which we want to see the tracking service
 *
 * @return TrackingSummary * - the summary of all the tracking services related to the campaign
 */
+ (NSDictionary *)getSummaryWithAccessToken:(NSString *)accessToken andCampaignId:(NSString *)campaignId;

@end
