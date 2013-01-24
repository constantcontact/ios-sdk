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
 * @return NSArray* - the function returns the array of contact lists belonging to the user authenthicated by the token;
 */
+(NSArray*)listsWithAccessToken:(NSString*)accessToken;

 /**
 * Function that adds a contact list to a user identified by a token;
 *
 * @param NSString* accessToken - Constant Contact OAuth2 access token, obtained after login;
 * @param ContactList* list - the list to be added to the users list collection;
 *
 * @return ContactList* - the function returns the added contact list in case of succes;
 */
+(ContactList*)addList:(ContactList*)list withAccessToken:(NSString*)accessToken;

 /**
 * Function that gets a specific contact list from the user identified by a token;
 *
 * @param NSString* accessToken - Constant Contact OAuth2 access token, obtained after login;
 * @param NSString* listID - the id of the list you wish to obtain;
 *
 * @return ContactList* - the function returns the contact list who is identified by listID;
 */
+(ContactList*)listWithAccessToken:(NSString*)accessToken andListId:(NSString*)listId;

@end
