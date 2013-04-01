//
//  CampaignScheduleService.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Config.h"
#import "Schedule.h"
#import "TestSend.h"
#import "HttpRequest.h"

/**
 * Performs all actions pertaining to scheduling Constant Contact Campaigns
 *
 */
@interface CampaignScheduleService : NSObject

/**
 * Create a new schedule for a campaign
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *campaignId - Campaign id to be scheduled
 * @param Schedule *schedule - Schedule to be created
 *
 * @return HttpResponse * - response containing either errors or data with the schedule that was created
 */
+ (HttpResponse*)addScheduleWithAccesToken:(NSString *)accessToken campaignId:(NSString *)campaignId andSchedule:(Schedule *)schedule;

/**
 * Get a list of schedules for a campaign
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *campaignId - id of the Campaign to which we want to see the schedules
 *
 * @return HttpResponse * - response containing either errors or data with a Array with the scheduels of a specific campaign
 */
+ (HttpResponse*)getSchedulesWithAccesToken:(NSString *)accessToken andCampaignId:(NSString *)campaignId;

/**
 * Get a specific schedule for a campaign
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *campaignId - id of the Campaign to which we want to see the schedules
 * @param NSString *scheudleId - id of the Schedule we want to see
 *
 * @return HttpResponse * - response containing either errors or data with the specific Schedule we required if it exists
 */
+ (HttpResponse*)getScheduleWithAccesToken:(NSString *)accessToken campaignId:(NSString *)campaignId andScheduleId:(NSString *)scheduleId;

/**
 * Update a specific schedule for a campaign
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *campaignId - id of the Campaign to which we want to see the schedules
 * @param Schedule *schedule - Schedule to update
 *
 * @return HttpResponse * - response containing either errors or data with the updated Schedule
 */
+ (HttpResponse*)updateScheduleWithAccesToken:(NSString *)accessToken campaignId:(NSString *)campaignId andSchedule:(Schedule *)schedule;

/**
 * Delete a specific schedule for a campaign
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *campaignId - id of the Campaign to which we want to see the schedules
 * @param NSString *scheudleId - id of the Schedule we want to delete
 *
 * @return bool - if the schedule was deleted or not
 */
+ (BOOL)deleteScheduleWithAccesToken:(NSString *)accessToken campaignId:(NSString *)campaignId andScheduleId:(NSString *)scheduleId errors:(NSArray**)errors;

/**
 * Send a test send of a campaign
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *campaignId - id of the Campaign to which we want to see the schedules
 * @param TestSend *testSend - Test send details
 *
 * @return HttpResponse * - response containing either errors or data with the TestSend return
 */
+ (HttpResponse*)sendTestWithAccesToken:(NSString *)accessToken campaignId:(NSString *)campaignId andTestSend:(TestSend *)testSend;

@end
