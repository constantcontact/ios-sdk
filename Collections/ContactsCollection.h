//
//  ContactsCollection.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contact.h"
#import "Collection.h"

@interface ContactsCollection : NSObject


 /**
 * Function gets all contacts belonging to the user identified by the token;
 *
 * @param NSString* accessToken - Constant Contact OAuth2 access token, obtained after login; 
 *
 * @return NSArray* - The function returns a array of all contacts belonging to the user identified by the token;
 */
+(NSArray*)contactsWithAccessToken:(NSString*)accessToken;

 /**
 * Function gets the contact details for a specific contact, belonging to the user identified by the token;
 *
 * @param NSString* accessToken - Constant Contact OAuth2 access token, obtained after login;
 * @param int contactId - The id of the contact that we want to get;
 *
 * @return Contact* - The function returns the information related to the contact with the given id;
 */
+(Contact*)contactWithAccessToken:(NSString*)accessToken andId:(int)contactId;

 /**
 * Function gets the contacts with a specified email address, belonging to the user identified by the token;
 *
 * @param NSString* accessToken - Constant Contact OAuth2 access token, obtained after login;
 * @param NSString email - The e-mail address of the contacts that we want to get;
 *
 * @return NSArray* - The function returns a array containing all the contacts that have the given e-mail address;
 */
+(NSArray*)contactsWithAccessToken:(NSString*)accessToken andEmail:(NSString*)email;

 /**
 * Function adds a new contact to the Constant Contact account belonging to the user identified by the token;
 *
 * @param NSString* accessToken - Constant Contact OAuth2 access token, obtained after login;
 * @param Contact* contact - The contact that we want to add;
 *
 * @return Contact* - The function returns the information related to the added contact if action was successful;
 */
+(Contact*)addContact:(Contact*)contact withAccessToken:(NSString*)accessToken;

 /**
 * Function deletes the contact details for a specific contact belonging to the user identified by the token;
 *
 * @param NSString* accessToken - Constant Contact OAuth2 access token, obtained after login;
 * @param Contact* contact - The contact that we want to add;
 * @param int contactId - The id of the contact that we want to delete;
 *
 * @return BOOL* - The function returns 1 or 0 depending on the success or failure of the delete action;
 */
+(BOOL)deleteContactWithAccessToken:(NSString*)accessToken andContactId:(int)contactId;

 /**
 * Function deletes a contact from all contact lists belonging to the user identified by the token;
 *
 * @param NSString* accessToken - Constant Contact OAuth2 access token, obtained after login;
 * @param int contactId - The id of the contact that we want to delete;
 *
 * @return BOOL* - The function returns 1 or 0 depending on the success or failure of the delete action;
 */
+(BOOL)deleteContactFromListsWithAccessToken:(NSString*)accessToken andContactId:(int)contactId;

 /**
 * Function deletes the contact details for a specific contact, from a specific contact list, belonging to the user identified by the token;
 *
 * @param NSString* accessToken - Constant Contact OAuth2 access token, obtained after login;
 * @param Contact* contact - The contact that we want to add;
 * @param int contactId - The id of the contact that we want to delete;
 * @param NSString* listId - The id of the list from which we want to delete the contact;
 *
 * @return BOOL* - The function returns 1 or 0 depending on the success or failure of the delete action;
 */
+(BOOL)deleteContactFromListWithAccessToken:(NSString*)accessToken andContactId:(int)contactId andListId:(NSString*)listId;

  /**
 * Function updates the contact details for a specific contact, belonging to the user identified by the token;
 *
 * @param NSString* accessToken - Constant Contact OAuth2 access token, obtained after login;
 * @param Contact* contact - The contact information that we want to update;
 *
 * @return Contact* - The function returns the information related to the updated contact if update is successful;
 */
+(Contact*)updateContact:(Contact*)contact withAccessToken:(NSString*)accessToken;

@end
