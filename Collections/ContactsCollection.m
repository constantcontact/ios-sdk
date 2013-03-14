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
+ (NSDictionary *)contactsWithAccessToken:(NSString*)accessToken
{
    NSMutableArray *contacts = [[NSMutableArray alloc] init];
    
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"contacts"];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    //-----token is set up as parameter, but it can also be sent in headers,
    //if it is then you must change the http request method too to acustom it
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    NSDictionary *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    NSMutableDictionary *sendBack = [[NSMutableDictionary alloc]init];
    if([response objectForKey:@"ERROR"])
        return response;
    else
    {
        if([response objectForKey:@"results"])
        {
            for (NSDictionary *contact in [response objectForKey:@"results"])
            {
                [contacts addObject:[Contact contactWithDictionary:contact]];
            }
        }
        [sendBack setObject:contacts forKey:@"data"];
    }
    
    return [sendBack mutableCopy];
}

// ----------------------------------------------------------------------------------------------------
// Get contact details for a specific contact
// accessToken - Constant Contact OAuth2 access token
// contactId - Unique contact id
// ----------------------------------------------------------------------------------------------------
+ (NSDictionary *)contactWithAccessToken:(NSString*)accessToken andId:(int)contactId
{
    Contact *contact = nil;
    
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"contact"];
    NSString *httpQuery = [NSString stringWithFormat:endpoint, contactId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?access_token=%@&api_key=%@", baseURL, httpQuery,accessToken,apiKey];
    NSDictionary *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    NSMutableDictionary *sendBack = [[NSMutableDictionary alloc]init];
    if([response objectForKey:@"ERROR"])
        return response;
    else
    {
         contact = [[Contact alloc] initWithDictionary:response];
        [sendBack setObject:contact forKey:@"data"];
    }
    
    return [sendBack mutableCopy];
}

// ----------------------------------------------------------------------------------------------------
// Get contacts with a specified email eaddress
// accessToken - Constant Contact OAuth2 access token
// email - contact email address to search for
// ----------------------------------------------------------------------------------------------------
+ (NSDictionary *)contactsWithAccessToken:(NSString*)accessToken andEmail:(NSString*)email
{
    NSMutableArray *contacts = [[NSMutableArray alloc] init];
    
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"contacts"];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"email=%@&access_token=%@&api_key=%@", email,accessToken,apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    NSDictionary *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    NSMutableDictionary *sendBack = [[NSMutableDictionary alloc]init];
    if([response objectForKey:@"ERROR"])
        return response;
    else
    {
        if([response objectForKey:@"results"])
        {
            for (NSDictionary *contact in [response objectForKey:@"results"])
            {
                [contacts addObject:[Contact contactWithDictionary:contact]];
            }
            
        }
        [sendBack setObject:contacts forKey:@"data"];
    }
    
    return [sendBack mutableCopy];
}

// ----------------------------------------------------------------------------------------------------
// Add a new contact to the Constant Contact account
// accessToken - Constant Contact OAuth2 access token
// contact - Contact to add
// ----------------------------------------------------------------------------------------------------
+ (NSDictionary *)addContact:(Contact*)contact withAccessToken:(NSString*)accessToken actionByVisitor:(BOOL)action
{
    Contact *returnContact = nil;
    
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"contacts"];
  //  NSString *apiKey = [Config valueForType:@"config" key:@"api_key"]; --to add to query if needed
    NSString *httpQuery = nil;
    if(action == YES)
    {
         httpQuery = [NSString stringWithFormat:@"action_by=ACTION_BY_VISITOR"];
    }
    else
    {
        httpQuery = [NSString stringWithFormat:@"action_by=ACTION_BY_OWNER"];
    }
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    NSString *jsonString = [contact toJsonForContact];
    
    NSArray *headerArray = [NSArray arrayWithObject:accessToken];
    
    NSDictionary *response = [HttpRequest postWithUrl:url andHeaders:headerArray andStringData:jsonString];
    
    NSMutableDictionary *sendBack = [[NSMutableDictionary alloc]init];
    if([response objectForKey:@"ERROR"])
        return response;
    else
    {
        returnContact = [[Contact alloc] initWithDictionary:response];
        [sendBack setObject:returnContact forKey:@"data"];
    }
    
    return [sendBack mutableCopy];
}

// ----------------------------------------------------------------------------------------------------
// Delete contact details for a specific contact
// accessToken - Constant Contact OAuth2 access token
// contactId - Unique contact id
// ----------------------------------------------------------------------------------------------------
+ (BOOL)deleteContactWithAccessToken:(NSString*)accessToken andContactId:(int)contactId
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"contact"];
    NSString *httpQuery = [NSString stringWithFormat:endpoint, contactId];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?access_token=%@&api_key=%@", baseURL, httpQuery,accessToken,apiKey];
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
+ (BOOL)deleteContactFromListsWithAccessToken:(NSString*)accessToken andContactId:(int)contactId
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"contact_lists"];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *httpQuery = [NSString stringWithFormat:endpoint, contactId];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?access_token=%@&api_key=%@", baseURL, httpQuery,accessToken,apiKey];
    
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
+ (BOOL)deleteContactFromListWithAccessToken:(NSString*)accessToken andContactId:(int)contactId andListId:(NSString*)listId
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"contact_list"];
    NSString *httpQuery = [NSString stringWithFormat:endpoint, contactId, listId];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *url = [NSString stringWithFormat:@"%@%@?access_token=%@&api_key=%@", baseURL, httpQuery,accessToken,apiKey];
    
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
+ (NSDictionary *)updateContact:(Contact*)contact withAccessToken:(NSString*)accessToken actionByVisitor:(BOOL)action
{
    Contact *returnContact = nil;
    
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"contact"];
 //   NSString *apiKey = [Config valueForType:@"config" key:@"api_key"]; add later
    NSString *httpQuery = [NSString stringWithFormat:endpoint, contact.id];
    NSString *httpQueryer = @"";
    
    if(action == YES)
    {
        httpQueryer = [NSString stringWithFormat:@"action_by=ACTION_BY_VISITOR"];
    }
    else
    {
        httpQueryer = [NSString stringWithFormat:@"action_by=ACTION_BY_OWNER"];
    }
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, httpQuery, httpQueryer];
    
    NSString *jsonString = [contact toJsonForContact];
    
    NSArray *headerArray = [NSArray arrayWithObject:accessToken];
    
    NSDictionary *response = [HttpRequest putWithUrl:url andHeaders:headerArray andStringData:jsonString];
    
    NSMutableDictionary *sendBack = [[NSMutableDictionary alloc]init];
    if([response objectForKey:@"ERROR"])
        return response;
    else
    {
        returnContact = [[Contact alloc] initWithDictionary:response];
        [sendBack setObject:returnContact forKey:@"data"];
    }
    
    return [sendBack mutableCopy];
}
@end
