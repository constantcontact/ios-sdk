//
//  ContactsCollection.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "ContactsCollection.h"
#import "Config.h"
#import "HttpRequest.h"

@implementation ContactsCollection

// ----------------------------------------------------------------------------------------------------
// Get an array of contacts
// accessToken - Constant Contact OAuth2 access token
// ----------------------------------------------------------------------------------------------------
+(NSArray*)contactsWithAccessToken:(NSString*)accessToken
{
    NSMutableArray *contacts = [[NSMutableArray alloc] init];
    
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"contacts"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@", accessToken];
    
    //-----token is set up as parameter, but it can also be sent in headers,
    //if it is then you must change the http request method too to acustom it
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    NSDictionary *response = [HttpRequest getWithUrl:url andHeaders:nil];
    for (int i=0;i<[response count];i++)
        [contacts addObject:[response objectForKey:[NSString stringWithFormat:@"DictNr%d",i]]];
 
    return [contacts copy];
}

// ----------------------------------------------------------------------------------------------------
// Get contact details for a specific contact
// accessToken - Constant Contact OAuth2 access token
// contactId - Unique contact id
// ----------------------------------------------------------------------------------------------------
+(Contact*)contactWithAccessToken:(NSString*)accessToken andId:(int)contactId
{
    Contact *contact = nil;
    
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"contact"];
    NSString *httpQuery = [NSString stringWithFormat:endpoint, contactId];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?access_token=%@", baseURL, httpQuery,accessToken];
    NSDictionary *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    contact = [[Contact alloc] initWithDictionary:response];
    
    return contact;
}

// ----------------------------------------------------------------------------------------------------
// Get contacts with a specified email eaddress
// accessToken - Constant Contact OAuth2 access token
// email - contact email address to search for
// ----------------------------------------------------------------------------------------------------
+(NSArray*)contactsWithAccessToken:(NSString*)accessToken andEmail:(NSString*)email
{
    NSMutableArray *contacts = [[NSMutableArray alloc] init];
    
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"contacts"];
    NSString *httpQuery = [NSString stringWithFormat:@"email=%@&access_token=%@", email,accessToken];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    NSDictionary *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    for (int i=0;i<[response count];i++)
        [contacts addObject:[response objectForKey:[NSString stringWithFormat:@"DictNr%d",i]]];
    
    return [contacts copy];
}

// ----------------------------------------------------------------------------------------------------
// Add a new contact to the Constant Contact account
// accessToken - Constant Contact OAuth2 access token
// contact - Contact to add
// ----------------------------------------------------------------------------------------------------
+(Contact*)addContact:(Contact*)contact withAccessToken:(NSString*)accessToken
{
    Contact *returnContact = nil;
    
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"contacts"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@",accessToken];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    NSString *jsonString = [contact toJson];
    NSDictionary *response = [HttpRequest postWithUrl:url andHeaders:nil andStringData:jsonString];
    returnContact = [[Contact alloc] initWithDictionary:response];
    
    return returnContact;
}

// ----------------------------------------------------------------------------------------------------
// Delete contact details for a specific contact
// accessToken - Constant Contact OAuth2 access token
// contactId - Unique contact id
// ----------------------------------------------------------------------------------------------------
+(BOOL)deleteContactWithAccessToken:(NSString*)accessToken andContactId:(int)contactId
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"contact"];
    NSString *httpQuery = [NSString stringWithFormat:endpoint, contactId];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?access_token=%@", baseURL, httpQuery,accessToken];
    NSDictionary *response = [HttpRequest deleteWithUrl:url andHeaders:nil];
    
    if( [[response objectForKey:@"code"] isEqualToString:@"204"])
    {
        return YES;
    }
    return NO;
}

// ----------------------------------------------------------------------------------------------------
// Delete a contact from all contact lists
// accessToken - Constant Contact OAuth2 access token
// contactId - Contact id to be removed from lists
// ----------------------------------------------------------------------------------------------------
+(BOOL)deleteContactFromListsWithAccessToken:(NSString*)accessToken andContactId:(int)contactId
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"contact_lists"];
    NSString *httpQuery = [NSString stringWithFormat:endpoint, contactId];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?access_token=%@", baseURL, httpQuery,accessToken];
    
    NSDictionary *response = [HttpRequest deleteWithUrl:url andHeaders:nil];
    
    if( [[response objectForKey:@"code"] isEqualToString:@"204"])
    {
        return YES;
    }
    return NO;
}

// ----------------------------------------------------------------------------------------------------
// Delete a contact from a specific contact list
// accessToken - Constant Contact OAuth2 access token
// contactId - Contact id to be removed
// listId - ContactList to remove the contact from
// ----------------------------------------------------------------------------------------------------
+(BOOL)deleteContactFromListWithAccessToken:(NSString*)accessToken andContactId:(int)contactId andListId:(NSString*)listId
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"contact_list"];
    NSString *httpQuery = [NSString stringWithFormat:endpoint, contactId, listId];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?access_token=%@", baseURL, httpQuery,accessToken];
    
    NSDictionary *response = [HttpRequest deleteWithUrl:url andHeaders:nil];
    
    if( [[response objectForKey:@"code"] isEqualToString:@"204"])
    {
        return YES;
    }
    return NO;
}

// ----------------------------------------------------------------------------------------------------
// Update contact details for a specific contact
// accessToken - Constant Contact OAuth2 access token
// contact - Contact to be updated
// ----------------------------------------------------------------------------------------------------
+(Contact*)updateContact:(Contact*)contact withAccessToken:(NSString*)accessToken
{
    Contact *returnContact = nil;
    
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"contact"];
    NSString *httpQuery = [NSString stringWithFormat:endpoint, contact.id];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?access_token=%@", baseURL, httpQuery,accessToken];
    
    NSString *jsonString = [contact toJson];
    NSDictionary *response = [HttpRequest putWithUrl:url andHeaders:nil andStringData:jsonString];
    returnContact = [[Contact alloc] initWithDictionary:response];
    
    return returnContact;
}
@end
