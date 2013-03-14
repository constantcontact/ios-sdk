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
 * @return NSDictionary * -dictionary containing either @"ERROR" or @"data" with a array of all contacts belonging to the user identified by the token;
 */
+ (NSDictionary *)contactsWithAccessToken:(NSString*)accessToken;

 /**
 * Function gets the contact details for a specific contact, belonging to the user identified by the token;
 *
 * @param NSString* accessToken - Constant Contact OAuth2 access token, obtained after login;
 * @param int contactId - The id of the contact that we want to get;
 *
 * @return NSDictionary * -dictionary containing either @"ERROR" or @"data" with a Contact that has the information related to the contact with the given id;
 */
+ (NSDictionary *)contactWithAccessToken:(NSString*)accessToken andId:(int)contactId;

 /**
 * Function gets the contacts with a specified email address, belonging to the user identified by the token;
 *
 * @param NSString* accessToken - Constant Contact OAuth2 access token, obtained after login;
 * @param NSString email - The e-mail address of the contacts that we want to get;
 *
 * @return NSDictionary * -dictionary containing either @"ERROR" or @"data" with a array containing all the Contacts that have the given e-mail address;
 */
+ (NSDictionary *)contactsWithAccessToken:(NSString*)accessToken andEmail:(NSString*)email;

 /**
 * Function adds a new contact to the Constant Contact account belonging to the user identified by the token;
 *
 * @param NSString* accessToken - Constant Contact OAuth2 access token, obtained after login;
 * @param Contact* contact - The contact that we want to add;
 *
 *@return NSDictionary * -dictionary containing either @"ERROR" or @"data" with Contact with the information related to the added contact if action was successful;
 */
+ (NSDictionary *)addContact:(Contact*)contact withAccessToken:(NSString*)accessToken actionByVisitor:(BOOL)action;

 /**
 * Function deletes the contact details for a specific contact belonging to the user identified by the token;
 *
 * @param NSString* accessToken - Constant Contact OAuth2 access token, obtained after login;
 * @param Contact* contact - The contact that we want to add;
 * @param int contactId - The id of the contact that we want to delete;
 *
 * @return BOOL* - The function returns 1 or 0 depending on the success or failure of the delete action;
 */
+ (BOOL)deleteContactWithAccessToken:(NSString*)accessToken andContactId:(int)contactId;

 /**
 * Function deletes a contact from all contact lists belonging to the user identified by the token;
 *
 * @param NSString* accessToken - Constant Contact OAuth2 access token, obtained after login;
 * @param int contactId - The id of the contact that we want to delete;
 *
 * @return BOOL* - The function returns 1 or 0 depending on the success or failure of the delete action;
 */
+ (BOOL)deleteContactFromListsWithAccessToken:(NSString*)accessToken andContactId:(int)contactId;

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
+ (BOOL)deleteContactFromListWithAccessToken:(NSString*)accessToken andContactId:(int)contactId andListId:(NSString*)listId;

  /**
 * Function updates the contact details for a specific contact, belonging to the user identified by the token;
 *
 * @param NSString* accessToken - Constant Contact OAuth2 access token, obtained after login;
 * @param Contact* contact - The contact information that we want to update;
 *
 *@return NSDictionary * -dictionary containing either @"ERROR" or @"data" with a Contact with the information related to the updated contact if update is successful;
 */
+ (NSDictionary *)updateContact:(Contact*)contact withAccessToken:(NSString*)accessToken actionByVisitor:(BOOL)action;

@end
