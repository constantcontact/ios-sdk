//
//  CampaignTrackingService.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "CampaignTrackingService.h"

@implementation CampaignTrackingService

+ (NSDictionary *)getBouncesWithAccessToken:(NSString *)accessToken campaignID:(NSString *)campaignId andParams:(NSString *)params
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"campaign_tracking_bounces"],campaignId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    if(params.length > 0 )
        url  = [NSString stringWithFormat:@"%@&%@",url,params];
    
    NSDictionary *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    NSMutableDictionary *sendBack = [[NSMutableDictionary alloc]init];
    if([response objectForKey:@"ERROR"])
        return response;
    else
    {
        NSMutableArray *bounces = [[NSMutableArray alloc] init];
        
        for (NSDictionary *bounce in [response objectForKey:@"results"])
        {
            [bounces addObject:[BounceActivity bounceActivityWithDictionary:bounce]];
        }
        
        NSDictionary *meta= [response objectForKey:@"meta"];
        ResultSet *rez = [[ResultSet alloc]initResultSetWithResults:bounces andMeta:meta];
        [sendBack setObject:rez forKey:@"data"];
    }
    
    return [sendBack mutableCopy];
}

+ (NSDictionary *)getClicksWithAccessToken:(NSString *)accessToken campaignId:(NSString *)campaignId andParams:(NSString *)params
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"campaign_tracking_clicks"],campaignId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    if(params.length > 0 )
        url  = [NSString stringWithFormat:@"%@&%@",url,params];
    
    NSDictionary *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    NSMutableDictionary *sendBack = [[NSMutableDictionary alloc]init];
    if([response objectForKey:@"ERROR"])
        return response;
    else
    {
        NSMutableArray *clicks = [[NSMutableArray alloc] init];
        
        for (NSDictionary *click in [response objectForKey:@"results"])
        {
            [clicks addObject:[ClickActivity clickActivityWithDictionary:click]];
        }
        
        NSDictionary *meta= [response objectForKey:@"meta"];
        ResultSet *rez = [[ResultSet alloc]initResultSetWithResults:clicks andMeta:meta];
        [sendBack setObject:rez forKey:@"data"];
    }
    
    return [sendBack mutableCopy];
}

+ (NSDictionary *)getForwardsWithAccessToken:(NSString *)accessToken campaignId:(NSString *)campaignId andParams:(NSString *)params
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"campaign_tracking_forwards"],campaignId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    if(params.length > 0 )
        url  = [NSString stringWithFormat:@"%@&%@",url,params];
    
    NSDictionary *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    NSMutableDictionary *sendBack = [[NSMutableDictionary alloc]init];
    if([response objectForKey:@"ERROR"])
        return response;
    else
    {
        NSMutableArray *forwards = [[NSMutableArray alloc] init];
        
        for (NSDictionary *forward in [response objectForKey:@"results"])
        {
            [forwards addObject:[ForwardActivity forwardActivityWithDictionary:forward]];
        }
        
        NSDictionary *meta= [response objectForKey:@"meta"];
        ResultSet *rez = [[ResultSet alloc]initResultSetWithResults:forwards andMeta:meta];
        [sendBack setObject:rez forKey:@"data"];
    }
    
    return [sendBack mutableCopy];
}

+ (NSDictionary *)getOpensWithAccessToken:(NSString *)accessToken campaignId:(NSString *)campaignId andParams:(NSString *)params
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"campaign_tracking_opens"],campaignId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    if(params.length > 0 )
        url  = [NSString stringWithFormat:@"%@&%@",url,params];
    
    NSDictionary *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    NSMutableDictionary *sendBack = [[NSMutableDictionary alloc]init];
    if([response objectForKey:@"ERROR"])
        return response;
    else
    {
        NSMutableArray *opens = [[NSMutableArray alloc] init];
        
        for (NSDictionary *open in [response objectForKey:@"results"])
        {
            [opens addObject:[OpenActivity openActivityWithDictionary:open]];
        }
        
        NSDictionary *meta= [response objectForKey:@"meta"];
        ResultSet *rez = [[ResultSet alloc]initResultSetWithResults:opens andMeta:meta];
        [sendBack setObject:rez forKey:@"data"];
    }
    
    return [sendBack mutableCopy];
}

+ (NSDictionary *)getSendsWithAccessToken:(NSString *)accessToken campaignId:(NSString *)campaignId andParams:(NSString *)params
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"campaign_tracking_sends"],campaignId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    if(params.length > 0 )
        url  = [NSString stringWithFormat:@"%@&%@",url,params];
    
    NSDictionary *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    NSMutableDictionary *sendBack = [[NSMutableDictionary alloc]init];
    if([response objectForKey:@"ERROR"])
        return response;
    else
    {
        NSMutableArray *sends = [[NSMutableArray alloc] init];
        
        for (NSDictionary *send in [response objectForKey:@"results"])
        {
            [sends addObject:[SendActivity sendActivityWithDictionary:send]];
        }
        
        NSDictionary *meta= [response objectForKey:@"meta"];
        ResultSet *rez = [[ResultSet alloc]initResultSetWithResults:sends andMeta:meta];
        [sendBack setObject:rez forKey:@"data"];
    }
    
    return [sendBack mutableCopy];
}

+ (NSDictionary *)getOptOutsWithAccessToken:(NSString *)accessToken campaignId:(NSString *)campaignId andParams:(NSString *)params
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"campaign_tracking_unsubscribes"],campaignId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    if(params.length > 0 )
        url  = [NSString stringWithFormat:@"%@&%@",url,params];
    
    
    NSDictionary *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    NSMutableDictionary *sendBack = [[NSMutableDictionary alloc]init];
    if([response objectForKey:@"ERROR"])
        return response;
    else
    {
        NSMutableArray *unsubscribes = [[NSMutableArray alloc] init];
        
        for (NSDictionary *unsubscribe in [response objectForKey:@"results"])
        {
            [unsubscribes addObject:[OptOutActivity optOutWithDictionary:unsubscribe]];
        }
        
        NSDictionary *meta= [response objectForKey:@"meta"];
        ResultSet *rez = [[ResultSet alloc]initResultSetWithResults:unsubscribes andMeta:meta];
        [sendBack setObject:rez forKey:@"data"];
    }
    
    return [sendBack mutableCopy];
}

+ (NSDictionary *)getSummaryWithAccessToken:(NSString *)accessToken andCampaignId:(NSString *)campaignId
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"campaign_tracking_summary"],campaignId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    NSDictionary *response = [HttpRequest getWithUrl:url andHeaders:nil];
   
    NSMutableDictionary *sendBack = [[NSMutableDictionary alloc]init];
    if([response objectForKey:@"ERROR"])
        return response;
    else
    {
       TrackingSummary *rez = [TrackingSummary trackingSummaryWithDictionary:response];
        [sendBack setObject:rez forKey:@"data"];
    }
    
    return [sendBack mutableCopy];
}

+ (NSDictionary *)getClicksByLinkwithAccessToken:(NSString *)accessToken campaignId:(NSString *)campaignId linkId:(NSString *)linkId andParams:(NSString *)params
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"campaign_tracking_link"],campaignId,linkId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    if(params.length > 0 )
        url  = [NSString stringWithFormat:@"%@&%@",url,params];
    
    
    NSDictionary *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    NSMutableDictionary *sendBack = [[NSMutableDictionary alloc]init];
    if([response objectForKey:@"ERROR"])
        return response;
    else
    {
        NSMutableArray *unsubscribes = [[NSMutableArray alloc] init];
        
        for (NSDictionary *unsubscribe in [response objectForKey:@"results"])
        {
            [unsubscribes addObject:[ClickActivity clickActivityWithDictionary:unsubscribe]];
        }
        
        NSDictionary *meta= [response objectForKey:@"meta"];
        ResultSet *rez = [[ResultSet alloc]initResultSetWithResults:unsubscribes andMeta:meta];
        [sendBack setObject:rez forKey:@"data"];
    }
    
    return [sendBack mutableCopy];
}

@end
