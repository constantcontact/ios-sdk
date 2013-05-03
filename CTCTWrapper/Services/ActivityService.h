//
//  ActivityService.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequest.h"
#import "Config.h"
#import "Schedule.h"
#import "TestSend.h"
#import "Activity.h"
#import "AddContacts.h"
//#import "RemoveFromLists.h"
#import "ExportContacts.h"
//#import "ClearLists.h"

/**
 * Performs all actions pertaining to scheduling Constant Contact Activities
 *
 */
@interface ActivityService : NSObject

/**
 * Get an array of activities
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 *
 * @return HttpResponse * - response containing either errors or data with a Array of all ActivitySummaryReports
 */
+ (HttpResponse*)getActivitesWithToken:(NSString *)accessToken;

/**
 * Get an specific activity
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *activityId - Activity id
 *
 * @return HttpResponse * - response containing either errors or data with the specific Activity referenced by the parameter id
 */
+ (HttpResponse*)getActivityWithToken:(NSString *)accessToken andActivityId:(NSString *)activityId;

/**
 * Create an Add Contacts Activity
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param AddContacts *addContact - the contacts that will be added with the activity
 *
 * @return HttpResponse * - response containing either errors or data with the specific Activity created
 */
+ (HttpResponse*)createAddContactsActivityWithToken:(NSString *)accessToken andContacts:(AddContacts *)addContacts;

/**
 * Create a Clear Lists Activity
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSArray *clearLists - Array of list id's to be cleared
 *
 * @return HttpResponse * - response containing either errors or data with the specific Activity created
 */
+ (HttpResponse*)addClearListActivityWithToken:(NSString *)accessToken andLists:(NSArray *)lists;

/**
 * Create an Export Contacts Activity
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param ExportContacts *exportContacts - the contacts that need exported
 *
 * @return HttpResponse * - response containing either errors or data with the specific Activity created 
 */
+ (HttpResponse*)addExportContactsActivityWithToken:(NSString *)accessToken andExportContacts:(ExportContacts *)exportContacts;

/**
 * Create a Remove Contacts From Lists Activity
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSArray *emailAddressed - the array of email addresses to specify which contacts will be removed
 * @param NSArray *lists - the list from which to remove the contacts
 *
 *@return HttpResponse * - response containing either errors or data with the specific Activity created 
 */
+ (HttpResponse*)addRemoveContactsFromListsActivityWithToken:(NSString *)accessToken emailAddresses:(NSArray *)emailAddresses andLists:(NSArray *)lists;

@end
