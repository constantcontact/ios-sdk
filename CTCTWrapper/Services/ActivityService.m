//
//  ActivityService.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "ActivityService.h"

@implementation ActivityService

+ (HttpResponse *)getActivitesWithToken:(NSString *)accessToken
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"activities"];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken]];
    
    if (response.statusCode == 200)
    {
        NSMutableArray *activities = [[NSMutableArray alloc] init];
        NSArray *result = response.data;
        
        for (NSDictionary *listDict in result)
        {
            Activity *activity = [Activity activityWithDictionary:listDict];
            [activities addObject:activity];
        }
        
        [response replaceDataWithNewData:activities];
    }
    
    return response;
}

+ (HttpResponse *)getActivityWithToken:(NSString *)accessToken andActivityId:(NSString *)activityId
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =   [NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"activity"],activityId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken]];
    
    if (response.statusCode == 200)
    {
        Activity *activity = [Activity activityWithDictionary:response.data];
        [response replaceDataWithNewData:activity];
    }

    return response;
}

+ (HttpResponse *)getActivityWithToken:(NSString *)accessToken status:(NSString *)status andType:(NSString *)type
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"activities"];

    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@&status=%@&type=%@", accessToken, apiKey, status,type];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken]];
    
    if (response.statusCode == 200)
    {
        NSArray *arr = (NSArray *)response.data;
        for (NSDictionary *act in arr) {
            Activity *activity = [Activity activityWithDictionary:act];
            [response replaceDataWithNewData:activity];
        }
    }
    
    return response;
}

+ (HttpResponse *)createAddContactsActivityWithToken:(NSString *)accessToken andContacts:(AddContacts *)addContacts
{
 
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"add_contacts_activity"];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    NSString *contactsJSON = [addContacts toJson];
    
    HttpResponse *response = [HttpRequest postWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken] andStringData:contactsJSON];
    
    if (response.statusCode == 201)
    {
        Activity *activity = [Activity activityWithDictionary:response.data];
        [response replaceDataWithNewData:activity];
    }
    
    return response;
}

+ (HttpResponse *)addClearListActivityWithToken:(NSString *)accessToken andLists:(NSArray *)lists
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =   [Config valueForType:@"endpoints" key:@"clear_lists_activity"];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:lists,@"lists", nil];
    NSString *stringData = [self toJson:dict];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest postWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken] andStringData:stringData];
    
    if (response.statusCode == 201)
    {
        Activity *activity = [Activity activityWithDictionary:response.data];
        [response replaceDataWithNewData:activity];
    }
    
    return response;
}

+ (HttpResponse *)addExportContactsActivityWithToken:(NSString *)accessToken andExportContacts:(ExportContacts *)exportContacts
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =   [Config valueForType:@"endpoints" key:@"export_contacts_activity"];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
  
    NSString *stringData = [exportContacts toJson];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest postWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken] andStringData:stringData];
    
    if (response.statusCode == 201)
    {
        Activity *activity = [Activity activityWithDictionary:response.data];
        [response replaceDataWithNewData:activity];
    }
    
    return response;
}

+ (HttpResponse *)addRemoveContactsFromListsActivityWithToken:(NSString *)accessToken emailAddresses:(NSArray *)emailAddresses andLists:(NSArray *)lists
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
    
    HttpResponse *response = [HttpRequest postWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken] andStringData:[self toJson:payload]];
    
    if (response.statusCode == 201)
    {
        Activity *activity = [Activity activityWithDictionary:response.data];
        [response replaceDataWithNewData:activity];
    }
    
    return response;
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

#pragma mark - multipart 
+ (HttpResponse *)addContactsMultipartWithToken:(NSString *)accessToken withFile:(NSString *)file toLists:(NSString *)lists
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"add_contacts_activity"];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    NSString *fileName = [file lastPathComponent];
    
    NSError *error;
    
    NSData *content = [[NSFileManager defaultManager] contentsAtPath:file];
    
    if(error)
    {
        NSLog(@"ERROR: %@",error.localizedDescription);
    }
    
    HttpResponse *response = [HttpRequest httpMultipartRequestWithUrl:url file:fileName data:content lists:lists];
    
    if (response.statusCode == 201)
    {
        Activity *activity = [Activity activityWithDictionary:response.data];
        [response replaceDataWithNewData:activity];
    }

    return response;
}

+ (HttpResponse *)removeContactsMultipartWithToken:(NSString *)accessToken withFile:(NSString *)file fromLists:(NSString *)lists
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =   [Config valueForType:@"endpoints" key:@"remove_from_lists_activity"];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    NSString *fileName = [file lastPathComponent];
    
    NSData *content = [[NSFileManager defaultManager] contentsAtPath:file];
    
    HttpResponse *response = [HttpRequest httpMultipartRequestWithUrl:url file:fileName data:content lists:lists];
    
    if (response.statusCode == 201)
    {
        Activity *activity = [Activity activityWithDictionary:response.data];
        [response replaceDataWithNewData:activity];
    }
    return response;
}

+ (HttpResponse *)getStatusReportForLast50Activites:(NSString *)accessToken
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =   [Config valueForType:@"endpoints" key:@"activities"];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest getWithUrl:url  andHeaders:[HttpRequest headersWithAccessToken:accessToken]];
    
    if (response.statusCode == 200)
    {
        NSArray *arr = (NSArray *)response.data;
        for (NSDictionary *act in arr) {
            Activity *activity = [Activity activityWithDictionary:act];
            [response replaceDataWithNewData:activity];
        }
    }
    return response;
}

@end
