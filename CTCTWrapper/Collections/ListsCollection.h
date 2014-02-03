//
//  ListsCollection.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequest.h"
#import "ContactList.h"
#import "Collection.h"

@interface ListsCollection : NSObject

 /**
 * Function that gets a array of lists of a user identified by a token;
 *
 * @param NSString* accessToken - Constant Contact OAuth2 access token, obtained after login;
 * @param NSDate* date = optional parameter used for filtering lists by modification date
 *
 * @return HttpResponse * - response containing either errors or data with the array of contact lists belonging to the user authenthicated by the token;
 */
+ (HttpResponse*)listsWithAccessToken:(NSString*)accessToken andModificationDate:(NSDate *)date;

 /**
 * Function that adds a contact list to a user identified by a token;
 *
 * @param NSString* accessToken - Constant Contact OAuth2 access token, obtained after login;
 * @param ContactList* list - the list to be added to the users list collection;
 *
 * @return HttpResponse * - response containing either errors or data with the added ContactList in case of succes;
 */
+ (HttpResponse*)addList:(ContactList*)list withAccessToken:(NSString*)accessToken;

 /**
 * Function that gets a specific contact list from the user identified by a token;
 *
 * @param NSString* accessToken - Constant Contact OAuth2 access token, obtained after login;
 * @param NSString* listID - the id of the list you wish to obtain;
 *
 * @return HttpResponse * - response containing either errors or data with the ContactList who is identified by listID;
 */
+ (HttpResponse*)listWithAccessToken:(NSString*)accessToken andListId:(NSString*)listId;

/**
 * Function that gets contacts from the list specified by the user;
 *
 * @param NSString* accessToken - Constant Contact OAuth2 access token, obtained after login;
 * @param NSString* listID - the id of the list you wish to obtain contacts from;
 * @param NSDate* date - (otional) results will be filtered by the date if it is provided, adding a date will invalidate the limit parameter
 * @param int limit - (optional) the number of elements to be returned, default 50;
 *
 * @return HttpResponse * - response containing either errors or data with a array of Contacts from the list;
 */
+ (HttpResponse*)getContactListMembershipWithAccessToken:(NSString*)accessToken fromList:(NSString*)listId withModificationDate:(NSDate *)date withAlimitOf:(int)limit;

/**
 * Function that updates a contact list
 *
 * @param NSString* accessToken - Constant Contact OAuth2 access token, obtained after login;
 * @param NSString* listID - the id of the list that will be updated;
 * @param ContactList *list - the list to be updated;
 *
 * @return HttpResponse * - response containing either errors or data with the updated ContactList;
 */
+ (HttpResponse*)updateListWithAccessToken:(NSString*)accessToken andListId:(NSString*)listId andList:(ContactList *)list;

/**
 * Function that delete a contact list
 *
 * @param NSString* accessToken - Constant Contact OAuth2 access token, obtained after login;
 * @param NSString* listID - the id of the list that will be deleted;
 *
 * @return HttpResponse * - response containing either errors or data with the updated ContactList;
 */
+ (BOOL)deleteListWithAccessToken:(NSString*)accessToken andListId:(NSString*)listId errors:(NSArray**)errors;



@end
