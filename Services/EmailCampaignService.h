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
 * @param int param - query param to be appended to the request
 *
 * @return HttpResponse * - response containing either errors or data with a ResultSet containing the pagination and campaigns related to the user.
 */

+ (HttpResponse *)getCampaignsWithToken:(NSString *)accessToken andParams:(NSString*)params;

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
