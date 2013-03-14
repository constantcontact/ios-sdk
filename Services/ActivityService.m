//
//  ActivityService.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "ActivityService.h"

@implementation ActivityService

+ (NSDictionary *)getActivitesWithToken:(NSString *)accessToken
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"activities"];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    NSDictionary *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    NSMutableDictionary *sendBack = [[NSMutableDictionary alloc]init];
    
    if([response objectForKey:@"ERROR"])
        return response;
    else
    {
        NSMutableArray *activites = [[NSMutableArray alloc] init];
        for (NSDictionary *activ in [response objectForKey:@"result"])
        {
            [activites addObject:[Activity activityWithDictionary:activ]];
        }
        
        [sendBack setObject:activites forKey:@"data"];
    }
    
    return [sendBack mutableCopy];

}

+ (NSDictionary *)getActivityWithToken:(NSString *)accessToken andActivityId:(NSString *)activityId
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =   [NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"activity"],activityId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    NSDictionary *response = [HttpRequest getWithUrl:url andHeaders:nil];
    NSMutableDictionary *sendBack = [[NSMutableDictionary alloc]init];
    
    if([response objectForKey:@"ERROR"])
        return response;
    else
    {
        Activity *activ = [Activity activityWithDictionary:response];
        [sendBack setObject:activ forKey:@"data"];
    }
    
    return [sendBack mutableCopy];
}

+ (NSDictionary *)createAddContactsActivityWithToken:(NSString *)accessToken andContacts:(AddContacts *)addContacts
{
 
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"add_contacts_activity"];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    NSString *jsonedString = [addContacts toJson];
    
    NSDictionary *response = [HttpRequest postWithUrl:url andHeaders:nil andStringData:jsonedString];
    NSMutableDictionary *sendBack = [[NSMutableDictionary alloc]init];
    
    if([response objectForKey:@"ERROR"])
        return response;
    else
    {
         Activity *activ = [Activity activityWithDictionary:response];
        [sendBack setObject:activ forKey:@"data"];
    }
    
    return [sendBack mutableCopy];
}

+ (NSDictionary *)addClearListActivityWithToken:(NSString *)accessToken andLists:(NSArray *)lists
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =   [Config valueForType:@"endpoints" key:@"clear_lists_activity"];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:lists,@"lists", nil];
    NSString *stringData = [self toJson:dict];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    NSDictionary *response = [HttpRequest postWithUrl:url andHeaders:nil andStringData:stringData];
    NSMutableDictionary *sendBack = [[NSMutableDictionary alloc]init];
    if([response objectForKey:@"ERROR"])
        return response;
    else
    {
        Activity *activ = [Activity activityWithDictionary:response];
        [sendBack setObject:activ forKey:@"data"];
    }
    
    return [sendBack mutableCopy];
}

+ (NSDictionary *)addExportContactsActivityWithToken:(NSString *)accessToken andExportContacts:(ExportContacts *)exportContacts
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =   [Config valueForType:@"endpoints" key:@"export_contacts_activity"];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
  
    NSString *stringData = [exportContacts toJson];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    NSDictionary *response = [HttpRequest postWithUrl:url andHeaders:nil andStringData:stringData];
    
    NSMutableDictionary *sendBack = [[NSMutableDictionary alloc]init];
    if([response objectForKey:@"ERROR"])
        return response;
    else
    {
        Activity *activ = [Activity activityWithDictionary:response];
        [sendBack setObject:activ forKey:@"data"];
    }
    
    return [sendBack mutableCopy];
}

+ (NSDictionary *)addRemoveContactsFromListsActivityWithToken:(NSString *)accessToken emailAddresses:(NSArray *)emailAddresses andLists:(NSArray *)lists
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =   [Config valueForType:@"endpoints" key:@"remove_from_lists_activity"];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    NSMutableArray *importData = [[NSMutableArray alloc]init];
    
    for (NSString *email in emailAddresses)
    {
        NSDictionary *ema = [[NSDictionary alloc]initWithObjectsAndKeys:[NSArray arrayWithObject:email],@"email_addresses", nil];
        [importData addObject:ema];
    }
    
    NSMutableDictionary *payload = [[NSMutableDictionary alloc]init];
    [payload setObject:lists forKey:@"lists"];
    [payload setObject:importData forKey:@"import_data"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    NSDictionary *response = [HttpRequest postWithUrl:url andHeaders:nil andStringData:[self toJson:payload]];
    
    NSMutableDictionary *sendBack = [[NSMutableDictionary alloc]init];
    if([response objectForKey:@"ERROR"])
        return response;
    else
    {
        Activity *activ = [Activity activityWithDictionary:response];
        [sendBack setObject:activ forKey:@"data"];
    }
    
    return [sendBack mutableCopy];
}
                              
+ (NSString *) toJson:(id)dict
{
        NSString *jsonDict = dict;
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&error];
        NSString *jsonString = @"";
        
        if (!jsonData) {
            NSLog(@"Got an error: %@", error);
        } else {
            jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
        
        return jsonString;
    }

@end
