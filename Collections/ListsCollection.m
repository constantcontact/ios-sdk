//
//  ListsCollection.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "ListsCollection.h"
#import "Config.h"
#import "HttpRequest.h"

@implementation ListsCollection

//------------------------------------------------------------------------------------
// Gets a array of lists
// accessToken - Constant Contact OAuth2 access token
//------------------------------------------------------------------------------------
+(NSArray*)listsWithAccessToken:(NSString*)accessToken
{
    NSMutableArray *lists = [[NSMutableArray alloc] init];
    
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"lists"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@", accessToken];
    
    //-----token is set up as parameter, but it can also be sent in headers,
    //if it is then you must change the http request method too to acustom it
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    NSDictionary *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    for (int i=0;i<[response count];i++)
        [lists addObject:[response objectForKey:[NSString stringWithFormat:@"DictNr%d",i]]];
    
    return [lists copy];    
}
//------------------------------------------------------------------------------------
// Add a contact list
// accessToken - Constant Contact OAuth2 access token
// list - the list to be added to your list collection
//------------------------------------------------------------------------------------
+(ContactList*)addList:(ContactList*)list withAccessToken:(NSString*)accessToken
{
    ContactList *returnContactList = nil;
    
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"lists"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@", accessToken];
    //-----token is set up as parameter, but it can also be sent in headers,
    //if it is then you must change the http request method too to acustom it
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    NSString *jsonString = [list toJson];
    
    NSDictionary *response = [HttpRequest postWithUrl:url andHeaders:nil andStringData:jsonString];
    returnContactList = [[ContactList alloc] initWithDictionary:response];
    
    return returnContactList;
}
//------------------------------------------------------------------------------------
// Get a specific contact list
// accessToken - Constant Contact OAuth2 access token
// listID - unique id for each list
//------------------------------------------------------------------------------------
+(ContactList*)listWithAccessToken:(NSString*)accessToken andListId:(NSString*)listId
{
    ContactList *returnContactList = nil;
    
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"list"];
    NSString *httpQuery = [NSString stringWithFormat:endpoint, listId];

    NSString *url = [NSString stringWithFormat:@"%@%@?access_token=%@", baseURL, httpQuery,accessToken];
    NSDictionary *response = [HttpRequest getWithUrl:url andHeaders:nil];
    returnContactList = [[ContactList alloc] initWithDictionary:response];
    return returnContactList;
}

@end
