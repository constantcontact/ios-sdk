//
//  ListsCollection.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactList.h"
#import "Collection.h"

@interface ListsCollection : NSObject

 /**
 * Function that gets a array of lists of a user identified by a token;
 *
 * @param NSString* accessToken - Constant Contact OAuth2 access token, obtained after login;
 *
 * @return NSDictionary * -dictionary containing either @"ERROR" or @"data" with the array of contact lists belonging to the user authenthicated by the token;
 */
+ (NSDictionary *)listsWithAccessToken:(NSString*)accessToken;

 /**
 * Function that adds a contact list to a user identified by a token;
 *
 * @param NSString* accessToken - Constant Contact OAuth2 access token, obtained after login;
 * @param ContactList* list - the list to be added to the users list collection;
 *
 * @return NSDictionary * -dictionary containing either @"ERROR" or @"data" with the added ContactList in case of succes;
 */
+ (NSDictionary *)addList:(ContactList*)list withAccessToken:(NSString*)accessToken;

 /**
 * Function that gets a specific contact list from the user identified by a token;
 *
 * @param NSString* accessToken - Constant Contact OAuth2 access token, obtained after login;
 * @param NSString* listID - the id of the list you wish to obtain;
 *
 * @return NSDictionary * -dictionary containing either @"ERROR" or @"data" with the ContactList who is identified by listID;
 */
+ (NSDictionary *)listWithAccessToken:(NSString*)accessToken andListId:(NSString*)listId;

/**
 * Function that gets contacts from the list specified by the user;
 *
 * @param NSString* accessToken - Constant Contact OAuth2 access token, obtained after login;
 * @param NSString* listID - the id of the list you wish to obtain contacts from;
 *
 * @return NSDictionary * -dictionary containing either @"ERROR" or @"data" with a array of Contacts from the list;
 */
+ (NSDictionary *)getContactsWithAccessToken:(NSString*)accessToken fromList:(NSString*)listId;

/**
 * Function that updates a contact list
 *
 * @param NSString* accessToken - Constant Contact OAuth2 access token, obtained after login;
 * @param NSString* listID - the id of the list that will be updated;
 * @param ContactList *list - the list to be updated;
 *
 * @return NSDictionary * -dictionary containing either @"ERROR" or @"data" with the updated ContactList;
 */
+ (NSDictionary *)updateAccessToken:(NSString*)accessToken andListId:(NSString*)listId andList:(ContactList *)list;

/**
 * Function that delete a contact list
 *
 * @param NSString* accessToken - Constant Contact OAuth2 access token, obtained after login;
 * @param NSString* listID - the id of the list that will be deleted;
 *
 * @return NSDictionary * -dictionary containing either @"ERROR" or @"data" with the updated ContactList;
 */
+ (BOOL)deleteListWithAccessToken:(NSString*)accessToken andListId:(NSString*)listId;



@end
