//
//  EmailCampaignService.m
//  ConstantContact
//
//  Copyright (c) 2013 ConstantContact. All rights reserved.
//

#import "EmailCampaignService.h"

@implementation EmailCampaignService

+ (NSDictionary *)addCampaignWithToken:(NSString *)accessToken andCampaign:(EmailCampaign *)campaign;
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"campaigns"];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *jsonedCampaign = [campaign toJsonShortList];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    NSDictionary *response = [HttpRequest postWithUrl:url andHeaders:nil andStringData:jsonedCampaign];
 
    NSMutableDictionary *sendBack = [[NSMutableDictionary alloc]init];
    if([response objectForKey:@"ERROR"])
        return response;
    else
    {
        EmailCampaign *campaignRez = [EmailCampaign emailCampaignWithDictionary:response];
        [sendBack setObject:campaignRez forKey:@"data"];
    }
    
    return [sendBack mutableCopy];
}

+ (NSDictionary *)getCampaignsWithToken:(NSString *)accessToken andParams:(NSString *)param;
{
    NSMutableArray *campaigns = [[NSMutableArray alloc] init];
    
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"campaigns"];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    if(param.length > 0)
    {
        httpQuery = [NSString stringWithFormat:@"%@&%@",httpQuery,param];
    }
    //-----token is set up as parameter, but it can also be sent in headers,
    //if it is then you must change the http request method too to acustom it
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    NSDictionary *response = [HttpRequest getWithUrl:url andHeaders:nil];
  
    NSMutableDictionary *sendBack = [[NSMutableDictionary alloc]init];
    if([response objectForKey:@"ERROR"])
        return response;
    else
    {
        for (NSDictionary *contact in [response objectForKey:@"results"])
        {
            [campaigns addObject:[EmailCampaign emailCampaignWithDictionary:contact]];
        }
        
        ResultSet *set = [[ResultSet alloc]initResultSetWithResults:campaigns andMeta:[response objectForKey:@"meta"]];
        [sendBack setObject:set forKey:@"data"];
    }
    
    return [sendBack mutableCopy];
}

+ (NSDictionary *)getCampaignWithToken:(NSString *)accessToken andCampaignId:(NSString *)campaignId;
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"campaign"],campaignId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    NSDictionary *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    NSMutableDictionary *sendBack = [[NSMutableDictionary alloc]init];
    if([response objectForKey:@"ERROR"])
        return response;
    else
    {
         EmailCampaign *campaign = [EmailCampaign emailCampaignWithDictionary:response];
        [sendBack setObject:campaign forKey:@"data"];
    }
    
    return [sendBack mutableCopy];
}

+ (BOOL)deleteCamapaignWithToken:(NSString *)accessToken andCamapaignId:(NSString *)campaignId;
{
    
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"campaign"],campaignId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    NSDictionary *response = [HttpRequest deleteWithUrl:url andHeaders:nil];
   
    BOOL ret = NO;
    if([[response objectForKey:@"code"]intValue] == 204)
       ret = YES;
    else
        ret = NO;
     return ret;
}

+ (NSDictionary *)updateCampaignWithToken:(NSString *)accessToken andEmailCampaign:(EmailCampaign *)emailCampaign
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"campaign"],emailCampaign.id];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *jsonedCampaign = [emailCampaign toJson];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    NSDictionary *response = [HttpRequest putWithUrl:url andHeaders:nil andStringData:jsonedCampaign];
    
    NSMutableDictionary *sendBack = [[NSMutableDictionary alloc]init];
    if([response objectForKey:@"ERROR"])
        return response;
    else
    {
         EmailCampaign *campaignRez = [EmailCampaign emailCampaignWithDictionary:response];
        [sendBack setObject:campaignRez forKey:@"data"];
    }
    
    return [sendBack mutableCopy];
}

@end
