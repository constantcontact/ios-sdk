//
//  ContactTrackingService.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "ContactTrackingService.h"

@implementation ContactTrackingService

+ (NSDictionary *)getBouncesWithAccessToken:(NSString *)accessToken contactId:(NSString *)contactId andParams:(NSString *)params
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"contact_tracking_bounces"],contactId];
    
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

+ (NSDictionary *)getClicksWithAccessToken:(NSString *)accessToken contactId:(NSString *)contactId andParams:(NSString *)params
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"contact_tracking_clicks"],contactId];
    
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

+ (NSDictionary *)getForwardsWithAccessToken:(NSString *)accessToken contactId:(NSString *)contactId andParams:(NSString *)params
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"contact_tracking_forwards"],contactId];
    
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

+ (NSDictionary *)getOpensWithAccessToken:(NSString *)accessToken contactId:(NSString *)contactId andParams:(NSString *)params
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"contact_tracking_opens"],contactId];
    
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

+ (NSDictionary *)getSendsWithAccessToken:(NSString *)accessToken contactId:(NSString *)contactId andParams:(NSString *)params
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"contact_tracking_sends"],contactId];
    
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

+ (NSDictionary *)getOptOutsWithAccessToken:(NSString *)accessToken contactId:(NSString *)contactId andParams:(NSString *)params
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"contact_tracking_unsubscribes"],contactId];
    
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

+ (NSDictionary *)getSummaryWithAccessToken:(NSString *)accessToken contactId:(NSString *)contactId
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"contact_tracking_summary"],contactId];
    
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

@end
