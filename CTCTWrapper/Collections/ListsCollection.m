//
//  ListsCollection.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "ListsCollection.h"

#import "ContactsCollection.h"
#import "ResultSet.h"
#import "Config.h"

@implementation ListsCollection

//------------------------------------------------------------------------------------
// Gets a array of lists
// accessToken - Constant Contact OAuth2 access token
//------------------------------------------------------------------------------------
+ (HttpResponse*)listsWithAccessToken:(NSString*)accessToken andModificationDate:(NSDate *)date
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"lists"];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken,apiKey];
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    NSString *dateString = [dateFormat stringFromDate:date];
    if(date)
    {
     httpQuery = [NSString stringWithFormat:@"modified_since=%@&access_token=%@&api_key=%@",dateString,accessToken,apiKey];
    }
    
    //-----token is set up as parameter, but it can also be sent in headers,
    //if it is then you must change the http request method too to acustom it
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:nil];

    if (response.statusCode == 200)
    {
        NSMutableArray *lists = [[NSMutableArray alloc] init];
        NSArray *resultArray = response.data;
        
        for (NSDictionary *listDict in resultArray)
        {
            ContactList *list = [[ContactList alloc] initWithDictionary:listDict];
            [lists addObject:list];
        }
        
        [response replaceDataWithNewData:lists];
    }

    return response;
}
//------------------------------------------------------------------------------------
// Add a contact list
// accessToken - Constant Contact OAuth2 access token
// list - the list to be added to your list collection
//------------------------------------------------------------------------------------
+ (HttpResponse*)addList:(ContactList*)list withAccessToken:(NSString*)accessToken
{
    ContactList *returnContactList = nil;
    
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"lists"];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken,apiKey];
    
    //-----token is set up as parameter, but it can also be sent in headers,
    //if it is then you must change the http request method too to acustom it
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    NSString *jsonString = [list JSON];
    
    HttpResponse *response = [HttpRequest postWithUrl:url andHeaders:nil andStringData:jsonString];
    
    if (response.statusCode == 201)
    {
        returnContactList = [[ContactList alloc] initWithDictionary:response.data];
        [response replaceDataWithNewData:returnContactList];
    }
    
    return response;
}
//------------------------------------------------------------------------------------
// Get a specific contact list
// accessToken - Constant Contact OAuth2 access token
// listID - unique id for each list
//------------------------------------------------------------------------------------
+ (HttpResponse*)listWithAccessToken:(NSString*)accessToken andListId:(NSString*)listId
{
    // request should't return an array if no listId specified
    if (listId.length == 0)
        listId = @"0";
    
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"list"];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:endpoint, listId];

    NSString *url = [NSString stringWithFormat:@"%@%@?access_token=%@&api_key=%@", baseURL, httpQuery,accessToken,apiKey];
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    if (response.statusCode == 200)
    {
        ContactList *returnContactList = [[ContactList alloc] initWithDictionary:response.data];
        [response replaceDataWithNewData:returnContactList];
    }
    
    return response;
}

+ (HttpResponse*)getContactListMembershipWithAccessToken:(NSString*)accessToken fromList:(NSString*)listId withModificationDate:(NSDate *)date withAlimitOf:(NSString *)limit
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"membership_list"];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:endpoint, listId];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?access_token=%@&api_key=%@", baseURL, httpQuery,accessToken,apiKey];
    
    if(date)
    {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
        NSString *dateString = [dateFormat stringFromDate:date];
        
        url = [NSString stringWithFormat:@"%@&modified_since=%@", url, dateString];
    }
    else if (limit && limit.length > 0)
    {
        url = [NSString stringWithFormat:@"%@&limit=%@", url, limit];
    }
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    if(response.statusCode == 200)
    {
        NSMutableArray *contacts = [[NSMutableArray alloc] init];
        NSArray *resultArray = [response.data objectForKey:@"results"];
        
        for (NSDictionary *contactDict in resultArray)
        {
            Contact *contact = [Contact contactWithDictionary:contactDict];
            [contacts addObject:contact];
        }
        
        NSDictionary *meta = [response.data objectForKey:@"meta"];
        ResultSet *resultSet = [[ResultSet alloc] initResultSetWithResults:[contacts copy] andMeta:meta];
        
        [response replaceDataWithNewData:resultSet];
    }
    return response;
}

+ (HttpResponse*)updateListWithAccessToken:(NSString*)accessToken andListId:(NSString*)listId andList:(ContactList *)list
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"list"];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:endpoint, listId];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?access_token=%@&api_key=%@", baseURL, httpQuery,accessToken,apiKey];
    NSString *listJSON = [list JSON];
    
    HttpResponse *response = [HttpRequest putWithUrl:url andHeaders:nil andStringData:listJSON];
    
    if (response.statusCode == 200)
    {
        ContactList *returnContactList = [[ContactList alloc] initWithDictionary:response.data];
        [response replaceDataWithNewData:returnContactList];
    }
    
    return response;
}

+ (BOOL)deleteListWithAccessToken:(NSString*)accessToken andListId:(NSString*)listId errors:(NSArray**)errors
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"list"];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:endpoint, listId];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?access_token=%@&api_key=%@", baseURL, httpQuery,accessToken,apiKey];
    
    HttpResponse *response = [HttpRequest deleteWithUrl:url andHeaders:nil];
    
    *errors = response.errors;
    
    return (response.statusCode == 204);
}

@end
