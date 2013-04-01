//
//  ContactTrackingService.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "ContactTrackingService.h"

@implementation ContactTrackingService

+ (HttpResponse*)getBouncesWithAccessToken:(NSString *)accessToken contactId:(NSString *)contactId andParams:(NSString *)params
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"contact_tracking_bounces"],contactId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    if(params.length > 0 )
        url  = [NSString stringWithFormat:@"%@&%@",url,params];
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    if (response.statusCode == 200)
    {
        NSMutableArray *bounces = [[NSMutableArray alloc] init];
        NSArray *resultArray = [response.data objectForKey:@"results"];
        
        for (NSDictionary *bounceDict in resultArray)
        {
            BounceActivity *bounce = [BounceActivity bounceActivityWithDictionary:bounceDict];
            [bounces addObject:bounce];
        }
        
        NSDictionary *meta = [response.data objectForKey:@"meta"];
        ResultSet *resultSet = [[ResultSet alloc] initResultSetWithResults:[bounces copy] andMeta:meta];
        
        [response replaceDataWithNewData:resultSet];
    }
    
    return response;
}

+ (HttpResponse*)getClicksWithAccessToken:(NSString *)accessToken contactId:(NSString *)contactId andParams:(NSString *)params
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"contact_tracking_clicks"],contactId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    if(params.length > 0 )
        url  = [NSString stringWithFormat:@"%@&%@",url,params];
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    if (response.statusCode == 200)
    {
        NSMutableArray *clicks = [[NSMutableArray alloc] init];
        NSArray *resultArray = [response.data objectForKey:@"results"];
        
        for (NSDictionary *clickDict in resultArray)
        {
            ClickActivity *click = [ClickActivity clickActivityWithDictionary:clickDict];
            [clicks addObject:click];
        }
        
        NSDictionary *meta = [response.data objectForKey:@"meta"];
        ResultSet *resultSet = [[ResultSet alloc] initResultSetWithResults:[clicks copy] andMeta:meta];
        
        [response replaceDataWithNewData:resultSet];
    }
    
    return response;
}

+ (HttpResponse*)getForwardsWithAccessToken:(NSString *)accessToken contactId:(NSString *)contactId andParams:(NSString *)params
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"contact_tracking_forwards"],contactId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    if(params.length > 0 )
        url  = [NSString stringWithFormat:@"%@&%@",url,params];
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    if (response.statusCode == 200)
    {
        NSMutableArray *forwards = [[NSMutableArray alloc] init];
        NSArray *resultArray = [response.data objectForKey:@"results"];
        
        for (NSDictionary *forwardDict in resultArray)
        {
            ForwardActivity *forward = [ForwardActivity forwardActivityWithDictionary:forwardDict];
            [forwards addObject:forward];
        }
        
        NSDictionary *meta = [response.data objectForKey:@"meta"];
        ResultSet *resultSet = [[ResultSet alloc] initResultSetWithResults:[forwards copy] andMeta:meta];
        
        [response replaceDataWithNewData:resultSet];
    }
    
    return response;
}

+ (HttpResponse*)getOpensWithAccessToken:(NSString *)accessToken contactId:(NSString *)contactId andParams:(NSString *)params
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"contact_tracking_opens"],contactId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    if(params.length > 0 )
        url  = [NSString stringWithFormat:@"%@&%@",url,params];
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    if (response.statusCode == 200)
    {
        NSMutableArray *opens = [[NSMutableArray alloc] init];
        NSArray *resultArray = [response.data objectForKey:@"results"];
        
        for (NSDictionary *openDict in resultArray)
        {
            OpenActivity *open = [OpenActivity openActivityWithDictionary:openDict];
            [opens addObject:open];
        }
        
        NSDictionary *meta = [response.data objectForKey:@"meta"];
        ResultSet *resultSet = [[ResultSet alloc] initResultSetWithResults:[opens copy] andMeta:meta];
        
        [response replaceDataWithNewData:resultSet];
    }
    
    return response;
}

+ (HttpResponse*)getSendsWithAccessToken:(NSString *)accessToken contactId:(NSString *)contactId andParams:(NSString *)params
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"contact_tracking_sends"],contactId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    if(params.length > 0 )
        url  = [NSString stringWithFormat:@"%@&%@",url,params];
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    if (response.statusCode == 200)
    {
        NSMutableArray *sends = [[NSMutableArray alloc] init];
        NSArray *resultArray = [response.data objectForKey:@"results"];
        
        for (NSDictionary *sendDict in resultArray)
        {
            SendActivity *send = [SendActivity sendActivityWithDictionary:sendDict];
            [sends addObject:send];
        }
        
        NSDictionary *meta = [response.data objectForKey:@"meta"];
        ResultSet *resultSet = [[ResultSet alloc] initResultSetWithResults:[sends copy] andMeta:meta];
        
        [response replaceDataWithNewData:resultSet];
    }
    
    return response;
}

+ (HttpResponse*)getOptOutsWithAccessToken:(NSString *)accessToken contactId:(NSString *)contactId andParams:(NSString *)params
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"contact_tracking_unsubscribes"],contactId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    if(params.length > 0 )
        url  = [NSString stringWithFormat:@"%@&%@",url,params];
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    if (response.statusCode == 200)
    {
        NSMutableArray *unsubscribes = [[NSMutableArray alloc] init];
        NSArray *resultArray = [response.data objectForKey:@"results"];
        
        for (NSDictionary *unsubscribeDict in resultArray)
        {
            OptOutActivity *unsubscribe = [OptOutActivity optOutWithDictionary:unsubscribeDict];
            [unsubscribes addObject:unsubscribe];
        }
        
        NSDictionary *meta = [response.data objectForKey:@"meta"];
        ResultSet *resultSet = [[ResultSet alloc] initResultSetWithResults:[unsubscribes copy] andMeta:meta];
        
        [response replaceDataWithNewData:resultSet];
    }
    
    return response;
}

+ (HttpResponse*)getSummaryWithAccessToken:(NSString *)accessToken contactId:(NSString *)contactId
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"contact_tracking_summary"],contactId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    if (response.statusCode == 200)
    {
        TrackingSummary *summary = [TrackingSummary trackingSummaryWithDictionary:response.data];
        [response replaceDataWithNewData:summary];
    }
    
    return response;
}

@end
