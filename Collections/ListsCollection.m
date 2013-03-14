//
//  ListsCollection.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "ListsCollection.h"
#import "Config.h"
#import "HttpRequest.h"
#import "ContactsCollection.h"

@implementation ListsCollection

//------------------------------------------------------------------------------------
// Gets a array of lists
// accessToken - Constant Contact OAuth2 access token
//------------------------------------------------------------------------------------
+ (NSDictionary *)listsWithAccessToken:(NSString*)accessToken
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"lists"];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken,apiKey];
    
    //-----token is set up as parameter, but it can also be sent in headers,
    //if it is then you must change the http request method too to acustom it
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    NSDictionary *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    NSMutableDictionary *sendBack = [[NSMutableDictionary alloc]init];
    if([response objectForKey:@"ERROR"])
        return response;
    else
    {
        NSArray * arr = nil;
        if([response objectForKey:@"result"])
            arr = [response objectForKey:@"result"];
        [sendBack setObject:arr forKey:@"data"];
    }
    
    return [sendBack mutableCopy];
}
//------------------------------------------------------------------------------------
// Add a contact list
// accessToken - Constant Contact OAuth2 access token
// list - the list to be added to your list collection
//------------------------------------------------------------------------------------
+ (NSDictionary *)addList:(ContactList*)list withAccessToken:(NSString*)accessToken
{
    ContactList *returnContactList = nil;
    
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"lists"];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken,apiKey];
    
    //-----token is set up as parameter, but it can also be sent in headers,
    //if it is then you must change the http request method too to acustom it
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    NSString *jsonString = [list toJsonCampaigns];
    
    NSDictionary *response = [HttpRequest postWithUrl:url andHeaders:nil andStringData:jsonString];
    
    NSMutableDictionary *sendBack = [[NSMutableDictionary alloc]init];
    if([response objectForKey:@"ERROR"])
        return response;
    else
    {
       returnContactList = [[ContactList alloc] initWithDictionary:response];
       [sendBack setObject:returnContactList forKey:@"data"];
    }
    
    return [sendBack mutableCopy];
}
//------------------------------------------------------------------------------------
// Get a specific contact list
// accessToken - Constant Contact OAuth2 access token
// listID - unique id for each list
//------------------------------------------------------------------------------------
+ (NSDictionary *)listWithAccessToken:(NSString*)accessToken andListId:(NSString*)listId
{
    ContactList *returnContactList = nil;
    
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"list"];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:endpoint, listId];

    NSString *url = [NSString stringWithFormat:@"%@%@?access_token=%@&api_key=%@", baseURL, httpQuery,accessToken,apiKey];
    NSDictionary *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    NSMutableDictionary *sendBack = [[NSMutableDictionary alloc]init];
    if([response objectForKey:@"ERROR"])
        return response;
    else
    {
        returnContactList = [[ContactList alloc] initWithDictionary:response];
        [sendBack setObject:returnContactList forKey:@"data"];
    }
    
    return [sendBack mutableCopy];
}

+ (NSDictionary *)getContactsWithAccessToken:(NSString*)accessToken fromList:(NSString*)listId
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"membership_list"];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:endpoint, listId];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?access_token=%@&api_key=%@", baseURL, httpQuery,accessToken,apiKey];
    NSDictionary *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    NSMutableArray *rez = [[NSMutableArray alloc]init];
    NSMutableDictionary *sendBack = [[NSMutableDictionary alloc]init];
    if([response objectForKey:@"ERROR"])
        return response;
    else
    {
        for (NSDictionary * dict in [response objectForKey:@"results"])
        {
            Contact *cont = [Contact contactWithDictionary:dict];
            [rez addObject:cont];
        }
        [sendBack setObject:rez forKey:@"data"];
    }
    
    return [sendBack mutableCopy];
}

+ (NSDictionary *)updateAccessToken:(NSString*)accessToken andListId:(NSString*)listId andList:(ContactList *)list
{
    
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"list"];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:endpoint, listId];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?access_token=%@&api_key=%@", baseURL, httpQuery,accessToken,apiKey];
    NSString *jsonedList = [list toJsonCampaigns];
    
    NSDictionary *response = [HttpRequest putWithUrl:url andHeaders:nil andStringData:jsonedList];
    
   NSMutableDictionary *sendBack = [[NSMutableDictionary alloc]init];
    if([response objectForKey:@"ERROR"])
        return response;
    else
    {
        ContactList *uplist = [[ContactList alloc] initWithDictionary:response];
        [sendBack setObject:uplist forKey:@"data"];
    }
    
    return [sendBack mutableCopy];
}

+ (BOOL)deleteListWithAccessToken:(NSString*)accessToken andListId:(NSString*)listId
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"list"];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:endpoint, listId];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?access_token=%@&api_key=%@", baseURL, httpQuery,accessToken,apiKey];
    NSDictionary *response = [HttpRequest deleteWithUrl:url andHeaders:nil];
    
    if( [[response objectForKey:@"code"] isEqualToString:@"204"])
    {
        return YES;
    }
    return NO;
}

@end
