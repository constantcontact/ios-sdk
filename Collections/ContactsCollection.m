//
//  ContactsCollection.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "ContactsCollection.h"
#import "Config.h"

@implementation ContactsCollection

// ----------------------------------------------------------------------------------------------------
// Get an array of contacts
// accessToken - Constant Contact OAuth2 access token
// ----------------------------------------------------------------------------------------------------
+ (HttpResponse *)contactsWithAccessToken:(NSString*)accessToken
{    
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"contacts"];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    //-----token is set up as parameter, but it can also be sent in headers,
    //if it is then you must change the http request method too to acustom it
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:nil];
        
    if(response.statusCode == 200)
    {
        NSMutableArray *contacts = [[NSMutableArray alloc] init];
        NSArray *resultsArray = [response.data objectForKey:@"results"];

        for (NSDictionary *contact in resultsArray)
        {
            [contacts addObject:[Contact contactWithDictionary:contact]];
        }
        
        [response replaceDataWithNewData:[contacts copy]];
    }
    
    return response;
}

// ----------------------------------------------------------------------------------------------------
// Get contact details for a specific contact
// accessToken - Constant Contact OAuth2 access token
// contactId - Unique contact id
// ----------------------------------------------------------------------------------------------------
+ (HttpResponse *)contactWithAccessToken:(NSString*)accessToken andId:(NSString*)contactId
{
    // request should't return an array if no contactId specified
    if (contactId.length == 0)
        contactId = @"0";
    
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"contact"];
    NSString *httpQuery = [NSString stringWithFormat:endpoint, contactId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?access_token=%@&api_key=%@", baseURL, httpQuery,accessToken,apiKey];
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:nil];

    if (response.statusCode == 200)
    {
        Contact *returnContact = [[Contact alloc] initWithDictionary:response.data];
        [response replaceDataWithNewData:returnContact];
    }
    
    return response;
}

// ----------------------------------------------------------------------------------------------------
// Get contacts with a specified email eaddress
// accessToken - Constant Contact OAuth2 access token
// email - contact email address to search for
// ----------------------------------------------------------------------------------------------------
+ (HttpResponse *)contactsWithAccessToken:(NSString*)accessToken andEmail:(NSString*)email
{    
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"contacts"];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"email=%@&access_token=%@&api_key=%@", email,accessToken,apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    if(response.statusCode == 200)
    {
        NSMutableArray *contacts = [[NSMutableArray alloc] init];
        NSArray *resultsArray = [response.data objectForKey:@"results"];
        
        for (NSDictionary *contact in resultsArray)
        {
            [contacts addObject:[Contact contactWithDictionary:contact]];
        }
        
        [response replaceDataWithNewData:[contacts copy]];
    }
    
    return response;
}

// ----------------------------------------------------------------------------------------------------
// Add a new contact to the Constant Contact account
// accessToken - Constant Contact OAuth2 access token
// contact - Contact to add
// ----------------------------------------------------------------------------------------------------
+ (HttpResponse *)addContact:(Contact*)contact withAccessToken:(NSString*)accessToken actionByVisitor:(BOOL)action
{    
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"contacts"];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = action ? [NSString stringWithFormat:@"action_by=ACTION_BY_VISITOR"] : [NSString stringWithFormat:@"action_by=ACTION_BY_OWNER"];
   
    NSString *url = [NSString stringWithFormat:@"%@%@?%@&access_token=%@&api_key=%@", baseURL, endpoint, httpQuery, accessToken, apiKey];
    NSString *jsonString = [contact JSONForInsert];
    
    NSArray *headerArray = [NSArray arrayWithObject:accessToken];
    
    HttpResponse *response = [HttpRequest postWithUrl:url andHeaders:headerArray andStringData:jsonString];
    
    if (response.statusCode == 200 || response.statusCode == 201)
    {
        Contact *returnContact = [[Contact alloc] initWithDictionary:response.data];
        [response replaceDataWithNewData:returnContact];
    }
    
    return response;
}

// ----------------------------------------------------------------------------------------------------
// Delete contact details for a specific contact
// accessToken - Constant Contact OAuth2 access token
// contactId - Unique contact id
// ----------------------------------------------------------------------------------------------------
+ (BOOL)deleteContactWithAccessToken:(NSString*)accessToken andContactId:(NSString*)contactId errors:(NSArray**)errors
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"contact"];
    NSString *httpQuery = [NSString stringWithFormat:endpoint, contactId];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@&access_token=%@&api_key=%@", baseURL, httpQuery,accessToken,apiKey];
    HttpResponse *response = [HttpRequest deleteWithUrl:url andHeaders:nil];
    
    *errors = response.errors;
    
    return (response.statusCode == 204);
}

// ----------------------------------------------------------------------------------------------------
// Delete a contact from all contact lists
// accessToken - Constant Contact OAuth2 access token
// contactId - Contact id to be removed from lists
// ----------------------------------------------------------------------------------------------------
+ (BOOL)deleteContactFromListsWithAccessToken:(NSString*)accessToken andContactId:(NSString*)contactId errors:(NSArray**)errors
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"contact_lists"];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *httpQuery = [NSString stringWithFormat:endpoint, contactId];
    
    NSString *url = [NSString stringWithFormat:@"%@%@&access_token=%@&api_key=%@", baseURL, httpQuery,accessToken,apiKey];
    
    HttpResponse *response = [HttpRequest deleteWithUrl:url andHeaders:nil];
    
    *errors = response.errors;
    
    return (response.statusCode == 204);
}

// ----------------------------------------------------------------------------------------------------
// Delete a contact from a specific contact list
// accessToken - Constant Contact OAuth2 access token
// contactId - Contact id to be removed
// listId - ContactList to remove the contact from
// ----------------------------------------------------------------------------------------------------
+ (BOOL)deleteContactFromListWithAccessToken:(NSString*)accessToken andContactId:(NSString*)contactId andListId:(NSString*)listId errors:(NSArray**)errors
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"contact_list"];
    NSString *httpQuery = [NSString stringWithFormat:endpoint, contactId, listId];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *url = [NSString stringWithFormat:@"%@%@&access_token=%@&api_key=%@", baseURL, httpQuery,accessToken,apiKey];
    
    HttpResponse *response = [HttpRequest deleteWithUrl:url andHeaders:nil];
    
    *errors = response.errors;
    
    return (response.statusCode == 204);
}

// ----------------------------------------------------------------------------------------------------
// Update contact details for a specific contact
// accessToken - Constant Contact OAuth2 access token
// contact - Contact to be updated
// ----------------------------------------------------------------------------------------------------
+ (HttpResponse *)updateContact:(Contact*)contact withAccessToken:(NSString*)accessToken actionByVisitor:(BOOL)action
{    
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"contact"];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:endpoint, contact.contactId];
    NSString *httpQueryer = httpQueryer = action ? [NSString stringWithFormat:@"action_by=ACTION_BY_VISITOR"] : [NSString stringWithFormat:@"action_by=ACTION_BY_OWNER"];

    NSString *url = [NSString stringWithFormat:@"%@%@?%@&access_token=%@&api_key=%@", baseURL, httpQuery, httpQueryer, accessToken, apiKey];
    
    NSString *jsonString = [contact JSONForUpdate];
    
    NSArray *headerArray = [NSArray arrayWithObject:accessToken];
    
    HttpResponse *response = [HttpRequest putWithUrl:url andHeaders:headerArray andStringData:jsonString];
    
    if (response.statusCode == 200)
    {
        Contact *returnContact = [[Contact alloc] initWithDictionary:response.data];
        [response replaceDataWithNewData:returnContact];
    }
    
    return response;
}
@end
