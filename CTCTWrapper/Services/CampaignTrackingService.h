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
 * Please note that campaign tracking data is available for 180 days from the time the campaign was originally sent.
 * If you resend a campaign, the report data for the resend recipients is available for the same 180 day period as the original send data.
 */
@interface CampaignTrackingService : NSObject
/**
 * Get a result set of bounces for a given campaign
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *campaignId - id of the Campaign to which we want to see the tracking service
 * @param NSDate *date - (optional) if given only activites after the creation date will be returned, sending the date parameter will invalidate the limit parameter;
 * @param int limit - (optional) query param representing the number of items returned on a page;
 *
 * @return HttpResponse * - response containing either errors or data with a ResultsSet of BounceActivityes
 */
+ (HttpResponse*)getBouncesWithAccessToken:(NSString *)accessToken campaignID:(NSString *)campaignId creationDate:(NSDate *)date andALimitOf:(int)limit;

/**
 * Get clicks for a given campaign
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *campaignId - id of the Campaign to which we want to see the tracking service
 * @param NSDate *date - (optional) if given only activites after the creation date will be returned, sending the date parameter will invalidate the limit parameter;
 * @param int limit - (optional) query param representing the number of items returned on a page;
 *
 * @return HttpResponse * - response containing either errors or data with a ResultSet of ClickActivityes
 */
+ (HttpResponse*)getClicksWithAccessToken:(NSString *)accessToken campaignId:(NSString *)campaignId creationDate:(NSDate *)date andALimitOf:(int)limit;

/**
 * Get forwards for a given campaign
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *campaignId - id of the Campaign to which we want to see the tracking service
 * @param NSDate *date - (optional) if given only activites after the creation date will be returned, sending the date parameter will invalidate the limit parameter;
 * @param int limit - (optional) query param representing the number of items returned on a page;
 *
 * @return HttpResponse * - response containing either errors or data with a ResultSet of ForwardActivityes
 */

+ (HttpResponse*)getForwardsWithAccessToken:(NSString *)accessToken campaignId:(NSString *)campaignId creationDate:(NSDate *)date andALimitOf:(int)limit;

/**
 * Get opens for a given campaign
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *campaignId - id of the Campaign to which we want to see the tracking service
 * @param NSDate *date - (optional) if given only activites after the creation date will be returned, sending the date parameter will invalidate the limit parameter;
 * @param int limit - (optional) query param representing the number of items returned on a page;
 *
 * @return HttpResponse * - response containing either errors or data with a ResultSet of OpenActivityes
 */
+ (HttpResponse*)getOpensWithAccessToken:(NSString *)accessToken campaignId:(NSString *)campaignId creationDate:(NSDate *)date andALimitOf:(int)limit;

/**
 * Get sends for a given campaign
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *campaignId - id of the Campaign to which we want to see the tracking service
 * @param NSDate *date - (optional) if given only activites after the creation date will be returned, sending the date parameter will invalidate the limit parameter;
 * @param int limit - (optional) query param representing the number of items returned on a page;
 *
 * @return HttpResponse * - response containing either errors or data with a ResultSet of SendActivityes
 */
+ (HttpResponse*)getSendsWithAccessToken:(NSString *)accessToken campaignId:(NSString *)campaignId creationDate:(NSDate *)date andALimitOf:(int)limit;

/**
 * Get opt outs for a given campaign
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *campaignId - id of the Campaign to which we want to see the tracking service
 * @param NSDate *date - (optional) if given only activites after the creation date will be returned, sending the date parameter will invalidate the limit parameter;
 * @param int limit - (optional) query param representing the number of items returned on a page;
 *
 * @return HttpResponse * - response containing either errors or data with a ResultSet of OptOutActivityes;
 */
+ (HttpResponse*)getOptOutsWithAccessToken:(NSString *)accessToken campaignId:(NSString *)campaignId creationDate:(NSDate *)date andALimitOf:(int)limit;

/**
 * Get clicks for a specific link for a given campaign
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *campaignId - id of the Campaign to which we want to see the tracking service
 * @param NSString *linkId - the id of the specific link you want
 * @param NSDate *date - (optional) if given only activites after the creation date will be returned, sending the date parameter will invalidate the limit parameter;
 * @param int limit - (optional) query param representing the number of items returned on a page;
 *
 * @return HttpResponse * - response containing either errors or data with a ResultSet of all the Clicks on a specific link;
 */
+ (HttpResponse*)getClicksByLinkwithAccessToken:(NSString *)accessToken campaignId:(NSString *)campaignId linkId:(NSString *)linkId creationDate:(NSDate *)date andALimitOf:(int)limit;

/**
 * Get a summary of reporting data for a given campaign
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *campaignId - id of the Campaign to which we want to see the tracking service
 *
 * @return TrackingSummary * - the summary of all the tracking services related to the campaign
 */
+ (HttpResponse*)getSummaryWithAccessToken:(NSString *)accessToken andCampaignId:(NSString *)campaignId;

@end
