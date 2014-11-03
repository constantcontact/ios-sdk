//
//  AccountService.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "AccountService.h"

@implementation AccountService

+ (HttpResponse *)getAccountSummaryWithAccessToken:(NSString*)accessToken
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"account_summary"];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@",accessToken , apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken]];
    
    if (response.statusCode == 200)
    {
        AccountSummary *summary = [AccountSummary accountSummaryWithDictionary:response.data];
        [response replaceDataWithNewData:summary];
    }
    return response;
}

+ (HttpResponse *)updateAccountSummaryWithAccesToken:(NSString *)accessToken andSummary:(AccountSummary *)summary
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"account_summary"];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *summaryJson = [summary JSON];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest putWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken] andStringData:summaryJson];
    
    if (response.statusCode == 200)
    {
        AccountSummary *updatedSummary = [AccountSummary accountSummaryWithDictionary:response.data];
        [response replaceDataWithNewData:updatedSummary];
    }
    return response;
}

@end
