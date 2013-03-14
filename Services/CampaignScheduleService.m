//
//  CampaignScheduleService.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "CampaignScheduleService.h"

@implementation CampaignScheduleService

+ (NSDictionary *)addScheduleWithAccesToken:(NSString *)accessToken campaignId:(NSString *)campaignId andSchedule:(Schedule *)schedule;
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"campaign_schedules"],campaignId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *jsonedSchedule = [schedule toJson];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    NSDictionary *response = [HttpRequest postWithUrl:url andHeaders:nil andStringData:jsonedSchedule];
    
    NSMutableDictionary *sendBack = [[NSMutableDictionary alloc]init];
    if([response objectForKey:@"ERROR"])
        return response;
    else
    {
        Schedule *sched = [Schedule scheduleWithDictionary:response];
        [sendBack setObject:sched forKey:@"data"];
    }
    
    return [sendBack mutableCopy];
}

+ (NSDictionary *)getSchedulesWithAccesToken:(NSString *)accessToken andCampaignId:(NSString *)campaignId
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"campaign_schedules"],campaignId];
 
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    NSDictionary *response = [HttpRequest getWithUrl:url andHeaders:nil];

    NSMutableDictionary *sendBack = [[NSMutableDictionary alloc]init];
    if([response objectForKey:@"ERROR"])
        return response;
    else
    {
        NSMutableArray *sets = [[NSMutableArray alloc] init];
        
        if([response objectForKey:@"result"])
        {
            
            NSArray *tempArray = [response objectForKey:@"result"];
            for (int i=0; i< tempArray.count;i++)
            {
                [sets addObject:[Schedule scheduleWithDictionary:[tempArray objectAtIndex:i]]];
            }
        }

        [sendBack setObject:sets forKey:@"data"];
    }
    
    return [sendBack mutableCopy];
}

+ (NSDictionary *)getScheduleWithAccesToken:(NSString *)accessToken campaignId:(NSString *)campaignId andScheduleId:(NSString *)scheduleId
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"campaign_schedule"],campaignId,[scheduleId intValue]];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    NSDictionary *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    NSMutableDictionary *sendBack = [[NSMutableDictionary alloc]init];
    if([response objectForKey:@"ERROR"])
        return response;
    else
    {
        Schedule *schedule =[Schedule scheduleWithDictionary:response];
        [sendBack setObject:schedule forKey:@"data"];
    }
    
    return [sendBack mutableCopy];
}

+ (NSDictionary *)updateScheduleWithAccesToken:(NSString *)accessToken campaignId:(NSString *)campaignId andSchedule:(Schedule *)schedule
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"campaign_schedule"],campaignId,[schedule.scheduleId intValue]];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *jsonedSchedule = [schedule toJson];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    NSDictionary *response = [HttpRequest putWithUrl:url andHeaders:nil andStringData:jsonedSchedule];
    
    NSMutableDictionary *sendBack = [[NSMutableDictionary alloc]init];
    if([response objectForKey:@"ERROR"])
        return response;
    else
    {
       Schedule *sched = [Schedule scheduleWithDictionary:response];
        [sendBack setObject:sched forKey:@"data"];
    }
    
    return [sendBack mutableCopy];
}

+ (BOOL)deleteScheduleWithAccesToken:(NSString *)accessToken campaignId:(NSString *)campaignId andScheduleId:(NSString *)schedule
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"campaign_schedule"],campaignId,[schedule intValue]];
    
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

+ (NSDictionary *)sendTestWithAccesToken:(NSString *)accessToken campaignId:(NSString *)campaignId andTestSend:(TestSend *)testSend
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"campaign_test_sends"],campaignId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *jsonedTest = [testSend toJson];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    NSDictionary *response = [HttpRequest postWithUrl:url andHeaders:nil andStringData:jsonedTest];
    
    NSMutableDictionary *sendBack = [[NSMutableDictionary alloc]init];
    if([response objectForKey:@"ERROR"])
        return response;
    else
    {
       TestSend *test = [TestSend testSendWithDictionary:response];
        [sendBack setObject:test forKey:@"data"];
    }
    
    return [sendBack mutableCopy];

}


@end
