//
//  CampaignScheduleService.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "CampaignScheduleService.h"

@implementation CampaignScheduleService

+ (HttpResponse*)addScheduleWithAccesToken:(NSString *)accessToken campaignId:(NSString *)campaignId andSchedule:(Schedule *)schedule;
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"campaign_schedules"],campaignId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *scheduleJSON = [schedule JSON];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest postWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken] andStringData:scheduleJSON];
    
    if (response.statusCode == 201)
    {
        Schedule *schedule = [Schedule scheduleWithDictionary:response.data];
        [response replaceDataWithNewData:schedule];
    }
    
    return response;
}

+ (HttpResponse*)getSchedulesWithAccesToken:(NSString *)accessToken andCampaignId:(NSString *)campaignId
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"campaign_schedules"],campaignId];
 
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken]];
    
    if (response.statusCode == 200)
    {
        NSMutableArray *schedules = [[NSMutableArray alloc] init];
        NSMutableArray *resultArray = response.data;
        
        for (NSDictionary *scheduleDict in resultArray)
        {
            Schedule *schedule = [Schedule scheduleWithDictionary:scheduleDict];
            [schedules addObject:schedule];
        }
        
        [response replaceDataWithNewData:[schedules copy]];
    }
    
    return response;
}

+ (HttpResponse*)getScheduleWithAccesToken:(NSString *)accessToken campaignId:(NSString *)campaignId andScheduleId:(NSString *)scheduleId
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"campaign_schedule"], campaignId, scheduleId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken]];
    
    if (response.statusCode == 200)
    {
        Schedule *schedule = [Schedule scheduleWithDictionary:response.data];
        [response replaceDataWithNewData:schedule];
    }
    
    return response;
}

+ (HttpResponse*)updateScheduleWithAccesToken:(NSString *)accessToken campaignId:(NSString *)campaignId andSchedule:(Schedule *)schedule
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"campaign_schedule"], campaignId, schedule.scheduleId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *scheduleJSON = [schedule JSON];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest putWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken] andStringData:scheduleJSON];
    
    if (response.statusCode == 200)
    {
        Schedule *schedule = [Schedule scheduleWithDictionary:response.data];
        [response replaceDataWithNewData:schedule];
    }
    
    return response;
}

+ (BOOL)deleteScheduleWithAccesToken:(NSString *)accessToken campaignId:(NSString *)campaignId andScheduleId:(NSString *)schedule errors:(NSArray *__autoreleasing *)errors
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"campaign_schedule"],campaignId, schedule];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest deleteWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken]];
    
    *errors = response.errors;
    
    return (response.statusCode == 204);

}

+ (HttpResponse*)sendTestWithAccesToken:(NSString *)accessToken campaignId:(NSString *)campaignId andTestSend:(TestSend *)testSend
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"campaign_test_sends"],campaignId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *testJSON = [testSend JSON];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest postWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken] andStringData:testJSON];
    
    if (response.statusCode == 200)
    {
        TestSend *test = [TestSend testSendWithDictionary:response.data];
        [response replaceDataWithNewData:test];
    }
    
    return response;
}


@end
