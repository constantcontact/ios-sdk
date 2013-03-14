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
 * @return NSDictionary * -dictionary containing either @"ERROR" or @"data" with the Campaign that was created
 */
+ (NSDictionary *)addCampaignWithToken:(NSString *)accessToken andCampaign:(EmailCampaign *)campaign;

/**
 * Get a set of campaigns
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param int param - query param to be appended to the request
 *
 * @return NSDictionary * -dictionary containing either @"ERROR" or @"data" with a ResultSet containing the pagination and campaigns related to the user.
 */

+ (NSDictionary *)getCampaignsWithToken:(NSString *)accessToken andParams:(NSString *)param;

/**
 * Get campaign details for a specific campaign
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *campaignId - Valid campaign id
 *
 * @return NSDictionary * -dictionary containing either @"ERROR" or @"data" with the specific Campaign required.
 */
+ (NSDictionary *)getCampaignWithToken:(NSString *)accessToken andCampaignId:(NSString *)campaignId;

/**
 * Delete an email campaign
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *campaignId - Valid campaign id
 *
 * @return boolean - if the deletion action was succcesful or not
 */
+ (BOOL)deleteCamapaignWithToken:(NSString *)accessToken andCamapaignId:(NSString *)campaignId;

/**
 * Update a specific email campaign
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param Campaign *emailCampaign - Campaign to be updated
 *
 * @return NSDictionary * -dictionary containing either @"ERROR" or @"data" with the Campaign that was updated
 */
+ (NSDictionary *)updateCampaignWithToken:(NSString *)accessToken andEmailCampaign:(EmailCampaign *)emailCampaign;

@end
