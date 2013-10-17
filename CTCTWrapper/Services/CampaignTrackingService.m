//
//  CampaignTrackingService.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "CampaignTrackingService.h"

@implementation CampaignTrackingService

+ (HttpResponse*)getBouncesWithAccessToken:(NSString *)accessToken campaignID:(NSString *)campaignId creationDate:(NSDate *)date andALimitOf:(NSString *)limit
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"campaign_tracking_bounces"],campaignId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    if(date)
    {
        NSString *dateString = [self stringFromDate:date];
        
        httpQuery = [NSString stringWithFormat:@"%@&created_since=%@", httpQuery, dateString];
    }
    else if(limit.length > 0)
        httpQuery = [NSString stringWithFormat:@"%@&limit=%@", httpQuery, limit];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
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

+ (HttpResponse*)getClicksWithAccessToken:(NSString *)accessToken campaignId:(NSString *)campaignId creationDate:(NSDate *)date andALimitOf:(NSString *)limit
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"campaign_tracking_clicks"],campaignId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    if(date)
    {
        NSString *dateString = [self stringFromDate:date];
        
        httpQuery = [NSString stringWithFormat:@"%@&created_since=%@", httpQuery, dateString];
    }
    else if(limit.length > 0)
        httpQuery = [NSString stringWithFormat:@"%@&limit=%@", httpQuery, limit];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
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

+ (HttpResponse*)getForwardsWithAccessToken:(NSString *)accessToken campaignId:(NSString *)campaignId creationDate:(NSDate *)date andALimitOf:(NSString *)limit
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"campaign_tracking_forwards"],campaignId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    if(date)
    {
        NSString *dateString = [self stringFromDate:date];
        
        httpQuery = [NSString stringWithFormat:@"%@&created_since=%@", httpQuery, dateString];
    }
    else if(limit.length > 0)
        httpQuery = [NSString stringWithFormat:@"%@&limit=%@", httpQuery, limit];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];

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

+ (HttpResponse*)getOpensWithAccessToken:(NSString *)accessToken campaignId:(NSString *)campaignId creationDate:(NSDate *)date andALimitOf:(NSString *)limit
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"campaign_tracking_opens"],campaignId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    if(date)
    {
        NSString *dateString = [self stringFromDate:date];
        
        httpQuery = [NSString stringWithFormat:@"%@&created_since=%@", httpQuery, dateString];
    }
    else if(limit.length > 0)
        httpQuery = [NSString stringWithFormat:@"%@&limit=%@", httpQuery, limit];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
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

+ (HttpResponse*)getSendsWithAccessToken:(NSString *)accessToken campaignId:(NSString *)campaignId creationDate:(NSDate *)date andALimitOf:(NSString *)limit
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"campaign_tracking_sends"],campaignId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    if(date)
    {
        NSString *dateString = [self stringFromDate:date];
        
        httpQuery = [NSString stringWithFormat:@"%@&created_since=%@", httpQuery, dateString];
    }
    else if(limit.length > 0)
        httpQuery = [NSString stringWithFormat:@"%@&limit=%@", httpQuery, limit];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
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

+ (HttpResponse*)getOptOutsWithAccessToken:(NSString *)accessToken campaignId:(NSString *)campaignId creationDate:(NSDate *)date andALimitOf:(NSString *)limit
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"campaign_tracking_unsubscribes"],campaignId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    if(date)
    {
        NSString *dateString = [self stringFromDate:date];
        
        httpQuery = [NSString stringWithFormat:@"%@&created_since=%@", httpQuery, dateString];
    }
    else if(limit.length > 0)
        httpQuery = [NSString stringWithFormat:@"%@&limit=%@", httpQuery, limit];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
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

+ (HttpResponse*)getSummaryWithAccessToken:(NSString *)accessToken andCampaignId:(NSString *)campaignId
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"campaign_tracking_summary"],campaignId];
    
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

+ (HttpResponse*)getClicksByLinkwithAccessToken:(NSString *)accessToken campaignId:(NSString *)campaignId linkId:(NSString *)linkId creationDate:(NSDate *)date andALimitOf:(NSString *)limit
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"campaign_tracking_link"],campaignId,linkId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    if(date)
    {
        NSString *dateString = [self stringFromDate:date];
        
        httpQuery = [NSString stringWithFormat:@"%@&created_since=%@", httpQuery, dateString];
    }
    else if(limit.length > 0)
        httpQuery = [NSString stringWithFormat:@"%@&limit=%@", httpQuery, limit];
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
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

+ (NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSString *dateString = [dateFormat stringFromDate:date];
    
    return dateString;
}

@end
