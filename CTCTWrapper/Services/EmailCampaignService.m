//
//  EmailCampaignService.m
//  ConstantContact
//
//  Copyright (c) 2013 ConstantContact. All rights reserved.
//

#import "EmailCampaignService.h"

@implementation EmailCampaignService

+ (HttpResponse *)addCampaignWithToken:(NSString *)accessToken andCampaign:(EmailCampaign *)campaign;
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"campaigns"];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *campaignJSON = [campaign JSON];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest postWithUrl:url andHeaders:nil andStringData:campaignJSON];
 
    if (response.statusCode == 201)
    {
        EmailCampaign *campaign = [EmailCampaign emailCampaignWithDictionary:response.data];
        [response replaceDataWithNewData:campaign];
    }
    
    return response;
}

+ (HttpResponse *)getCampaignsWithToken:(NSString *)accessToken withALimitOf:(int)limit
{
    return [self getCampaignsWithToken:accessToken status:nil modificationDate:nil withALimitOf:limit];
}

+ (HttpResponse *)getCampaignsWithToken:(NSString *)accessToken status:(NSString *)status withALimitOf:(int)limit
{
    return [self getCampaignsWithToken:accessToken status:status modificationDate:nil withALimitOf:limit];
}

+ (HttpResponse *)getCampaignsWithToken:(NSString *)accessToken modificationDate:(NSDate *)date
{
    return [self getCampaignsWithToken:accessToken status:nil modificationDate:date withALimitOf:0];
}

+ (HttpResponse *)getCampaignsWithToken:(NSString *)accessToken status:(NSString *)status modificationDate:(NSDate *)date withALimitOf:(int)limit
{    
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"campaigns"];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    if(status && status.length > 0)
        httpQuery = [NSString stringWithFormat:@"%@&status=%@",httpQuery,status];
    
    if(date)
    {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        
        NSString *dateString = [dateFormat stringFromDate:date];
        
        httpQuery = [NSString stringWithFormat:@"%@&modified_since=%@",httpQuery,dateString];
    }
    else if(limit > 0)
        httpQuery = [NSString stringWithFormat:@"%@&limit=%d",httpQuery,limit];
    
    //-----token is set up as parameter, but it can also be sent in headers,
    //if it is then you must change the http request method too to acustom it
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    if (response.statusCode == 200)
    {
        NSMutableArray *campaigns = [[NSMutableArray alloc] init];
        NSArray *resultArray = [response.data objectForKey:@"results"];
        
        for (NSDictionary *campaignDict in resultArray)
        {
            EmailCampaign *campaign = [EmailCampaign emailCampaignWithDictionary:campaignDict];
            [campaigns addObject:campaign];
        }
        
        NSDictionary *meta = [response.data objectForKey:@"meta"];
        ResultSet *resultSet = [[ResultSet alloc] initResultSetWithResults:[campaigns copy] andMeta:meta];
        
        [response replaceDataWithNewData:resultSet];
    }
    
    return response;
}

+ (HttpResponse *)getCampaignWithToken:(NSString *)accessToken andCampaignId:(NSString *)campaignId;
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"campaign"],campaignId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    if (response.statusCode == 200)
    {
        EmailCampaign *campaign = [EmailCampaign emailCampaignWithDictionary:response.data];
        [response replaceDataWithNewData:campaign];
    }
    
    return response;;
}

+ (BOOL)deleteCamapaignWithToken:(NSString *)accessToken andCamapaignId:(NSString *)campaignId errors:(NSArray *__autoreleasing *)errors;
{
    if (campaignId.length == 0)
        campaignId = @"0";
    
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"campaign"],campaignId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest deleteWithUrl:url andHeaders:nil];
    
    *errors = response.errors;
       
    return (response.statusCode == 204);
}

+ (HttpResponse *)updateCampaignWithToken:(NSString *)accessToken andEmailCampaign:(EmailCampaign *)emailCampaign
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"campaign"],emailCampaign.campaignId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *campaignJSON = [emailCampaign JSON];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest putWithUrl:url andHeaders:nil andStringData:campaignJSON];
    
    if (response.statusCode == 200)
    {
        EmailCampaign *campaign = [EmailCampaign emailCampaignWithDictionary:response.data];
        [response replaceDataWithNewData:campaign];
    }
    
    return response;
}

@end
