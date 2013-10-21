//
//  EmailCampaignService.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Config.h"
#import "EmailCampaign.h"
#import "ResultSet.h"
#import "HttpRequest.h"
#import "Contact.h"

/**
 * Performs all actions pertaining to Constant Contact Campaigns
 *
 */
@interface EmailCampaignService : NSObject

/**
 * Create a new campaign
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param Campaign *campaign - Campign to be created
 *
 * @return HttpResponse * - response containing either errors or data with the Campaign that was created
 */
+ (HttpResponse *)addCampaignWithToken:(NSString *)accessToken andCampaign:(EmailCampaign *)campaign;

/**
 * Get a set of campaigns
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param int limit - (optional) limits the number of results returned
 *
 * @return HttpResponse * - response containing either errors or data with all the campaigns of the user
 */
+ (HttpResponse *)getCampaignsWithToken:(NSString *)accessToken withALimitOf:(NSString *)limit;

/**
 * Get a set of campaigns
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *status - the returned values are filtered by the sent status value
 * @param int limit - (optional) limits the number of results returned
 *
 * @return HttpResponse * - response containing either errors or data with all the campaigns with the given status
 */
+ (HttpResponse *)getCampaignsWithToken:(NSString *)accessToken status:(NSString *)status withALimitOf:(NSString *)limit;

/**
 * Get a set of campaigns
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSDate *date - the returned values are filtered by the sent modification date
 *
 * @return HttpResponse * - response containing either errors or data with all the campaigns with the modification date
 */

+ (HttpResponse *)getCampaignsWithToken:(NSString *)accessToken modificationDate:(NSDate *)date;

/**
 * Get campaign details for a specific campaign
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *campaignId - Valid campaign id
 *
 * @return HttpResponse * - response containing either errors or data with the specific Campaign required.
 */
+ (HttpResponse *)getCampaignWithToken:(NSString *)accessToken andCampaignId:(NSString *)campaignId;

/**
 * Delete an email campaign
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *campaignId - Valid campaign id
 *
 * @return boolean - if the deletion action was succcesful or not
 */
+ (BOOL)deleteCamapaignWithToken:(NSString *)accessToken andCamapaignId:(NSString *)campaignId errors:(NSArray**)errors;

/**
 * Update a specific email campaign
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param Campaign *emailCampaign - Campaign to be updated
 *
 * @return HttpResponse * - response containing either errors or data with the Campaign that was updated
 */
+ (HttpResponse *)updateCampaignWithToken:(NSString *)accessToken andEmailCampaign:(EmailCampaign *)emailCampaign;

@end
