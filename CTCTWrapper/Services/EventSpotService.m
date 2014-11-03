//
//  EventSpotService.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "EventSpotService.h"

@implementation EventSpotService

#pragma mark - event collection

+ (HttpResponse *)getEventCollectionWithAccessToken:(NSString*)accessToken withALimitOf:(int)limit
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"event_spot_collection"];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@",accessToken , apiKey];
    
    if(limit > 0)
    {
        httpQuery = [NSString stringWithFormat:@"%@&limit=%d",httpQuery , limit];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken]];
    
    if (response.statusCode == 200)
    {
        NSMutableArray *eventArray = [[NSMutableArray alloc] init];
        NSArray *resultArray = [response.data objectForKey:@"results"];
        
        for (NSDictionary *fileDict in resultArray)
        {
            Event *event = [Event eventWithDictionary:fileDict];
            [eventArray addObject:event];
        }
        NSDictionary *meta = [response.data objectForKey:@"meta"];
        ResultSet *resultSet = [[ResultSet alloc] initResultSetWithResults:[eventArray copy] andMeta:meta];
        
        [response replaceDataWithNewData:resultSet];
    }
    return response;
}

+ (HttpResponse*)addEventWithToken:(NSString *)accessToken andEvent:(EventExtended *)event
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"event_spot_collection"];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *eventExtendedJson = [event JSON];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest postWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken] andStringData:eventExtendedJson];
    
    if (response.statusCode == 201)
    {
        EventExtended *event = [EventExtended eventExtendedWithDictionary:response.data];
        [response replaceDataWithNewData:event];
    }
    return response;
}

#pragma mark - individual event

+ (HttpResponse *)getEventWithAccessToken:(NSString*)accessToken withEventId:(NSString *)eventId
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"event_spot_individual_event"],eventId];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@",accessToken , apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken]];
    
    if (response.statusCode == 200)
    {
        EventExtended *event = [EventExtended eventExtendedWithDictionary:response.data];
        [response replaceDataWithNewData:event];
    }
    return response;
}

+ (HttpResponse*)updateEventWithAccesToken:(NSString *)accessToken withEventId:(NSString *)eventId andEvent:(EventExtended *)event
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"event_spot_individual_event"],eventId];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *eventExtendedJson = [event JSON];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest putWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken] andStringData:eventExtendedJson];
    
    if (response.statusCode == 200)
    {
        EventExtended *event = [EventExtended eventExtendedWithDictionary:response.data];
        [response replaceDataWithNewData:event];
    }
    return response;
}
+ (HttpResponse*)patchEventWithAccesToken:(NSString *)accessToken withEventId:(NSString *)eventId action:(EventPatch *)patch
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"event_spot_individual_event"],eventId];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *eventExtendedJson = [patch JSON];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest patchWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken] andStringData:eventExtendedJson];
    
    if (response.statusCode == 200)
    {
        EventExtended *event = [EventExtended eventExtendedWithDictionary:response.data];
        [response replaceDataWithNewData:event];
    }
    return response;
}

#pragma mark - event fees collection

+ (HttpResponse *)getEventFeesCollectionWithAccessToken:(NSString*)accessToken withEventId:(NSString *)eventId
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"event_spot_fees_collection"],eventId];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@",accessToken , apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken]];
    
    if (response.statusCode == 200)
    {
        NSMutableArray *eventArray = [[NSMutableArray alloc] init];
        
        for (NSDictionary *eventDict in response.data)
        {
            EventFee *event = [EventFee eventFeeWithDictionary:eventDict];
            [eventArray addObject:event];
        }
        [response replaceDataWithNewData:eventArray];
    }
    return response;
}

+ (HttpResponse*)addEventFeeWithToken:(NSString *)accessToken withEventId:(NSString *)eventId andEventFee:(EventFee *)eventFee
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"event_spot_fees_collection"],eventId];

    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *eventFeeExtendedJson = [eventFee JSON];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest postWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken] andStringData:eventFeeExtendedJson];
    
    if (response.statusCode == 201)
    {
        EventFee *eventFee = [EventFee eventFeeWithDictionary:response.data];
        [response replaceDataWithNewData:eventFee];
    }
    return response;
}

#pragma mark - individual event fee

+ (HttpResponse *)getEventFeeWithAccessToken:(NSString*)accessToken withEventId:(NSString *)eventId andFeeId:(NSString *)feeId
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"event_spot_individual_fee"],eventId,feeId];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@",accessToken , apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken]];
    
    if (response.statusCode == 200)
    {
        EventFee *event = [EventFee eventFeeWithDictionary:response.data];
        [response replaceDataWithNewData:event];
    }
    return response;
}

+ (HttpResponse *)updateEventFeeWithAccesToken:(NSString*)accessToken withEventId:(NSString *)eventId feeId:(NSString *)feeId andEventFee:(EventFee *)eventFee
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"event_spot_individual_fee"],eventId,feeId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *eventFeeExtendedJson = [eventFee JSON];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest putWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken] andStringData:eventFeeExtendedJson];
    
    if (response.statusCode == 200)
    {
        EventFee *eventFee = [EventFee eventFeeWithDictionary:response.data];
        [response replaceDataWithNewData:eventFee];
    }
    return response;
}

+ (BOOL)deleteEventFeeWithAccesToken:(NSString*)accessToken withEventId:(NSString *)eventId andFeeId:(NSString *)feeId errors:(NSArray *__autoreleasing *)errors;
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"event_spot_individual_fee"],eventId,feeId];
        
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
        
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
        
    HttpResponse *response = [HttpRequest deleteWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken]];
        
    *errors = response.errors;
        
    return (response.statusCode == 204);
}

#pragma mark - promocode collection

+ (HttpResponse *)getPromocodeCollectionWithAccessToken:(NSString*)accessToken withEventId:(NSString *)eventId
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"event_spot_promocode_collection"],eventId];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@",accessToken , apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken]];
    
    if (response.statusCode == 200)
    {
        NSMutableArray *eventArray = [[NSMutableArray alloc] init];
        
        for (NSDictionary *eventDict in response.data)
        {
            EventPromocode *promo = [EventPromocode promocodeWithDictionary:eventDict];
            [eventArray addObject:promo];
        }
        [response replaceDataWithNewData:eventArray];
    }
    return response;
}

+ (HttpResponse *)addPromocodeWithAccesToken:(NSString*)accessToken withEventId:(NSString *)eventId  andPromocode:(EventPromocode *)promocode
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"event_spot_promocode_collection"],eventId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *eventFeeExtendedJson = [promocode JSON];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest postWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken] andStringData:eventFeeExtendedJson];
    
    if (response.statusCode == 201)
    {
        EventPromocode *eventFee = [EventPromocode promocodeWithDictionary:response.data];
        [response replaceDataWithNewData:eventFee];
    }
    return response;
}

#pragma mark - individual promocode

+ (HttpResponse *)getPromocodeWithAccessToken:(NSString*)accessToken withEventId:(NSString *)eventId andPromocodeId:(NSString *)promocodeId
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"event_spot_individual_promocode"],eventId,promocodeId];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@",accessToken , apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken]];
    
    if (response.statusCode == 200)
    {
        EventPromocode *promo = [EventPromocode promocodeWithDictionary:response.data];
        [response replaceDataWithNewData:promo];
    }
    return response;
}

+ (HttpResponse *)updatePromocodeWithAccessToken:(NSString*)accessToken withEventId:(NSString *)eventId andPromocodeId:(NSString *)promocodeId andPromocode:(EventPromocode *)promocode
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"event_spot_individual_promocode"],eventId,promocodeId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *eventFeeExtendedJson = [promocode JSON];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest putWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken] andStringData:eventFeeExtendedJson];
    
    if (response.statusCode == 200)
    {
        EventPromocode *promo = [EventPromocode promocodeWithDictionary:response.data];
        [response replaceDataWithNewData:promo];
    }
    return response;
}

+ (BOOL)deletePromocodeWithAccessToken:(NSString*)accessToken withEventId:(NSString *)eventId andPromocodeId:(NSString *)promocodeId errors:(NSArray *__autoreleasing *)errors;
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"event_spot_individual_promocode"],eventId,promocodeId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest deleteWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken]];
    
    *errors = response.errors;
    
    return (response.statusCode == 204);
}

#pragma mark - event registrant collection

+ (HttpResponse *)getEventRegistrantCollectionWithAccessToken:(NSString*)accessToken withEventId:(NSString *)eventId withALimitOf:(int)limit
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"event_spot_registration_collection"],eventId];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@",accessToken , apiKey];
    
    if(limit > 0)
    {
        httpQuery = [NSString stringWithFormat:@"%@&limit=%d",httpQuery , limit];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken]];
    
    if (response.statusCode == 200)
    {
        NSMutableArray *eventArray = [[NSMutableArray alloc] init];
        NSArray *resultArray = [response.data objectForKey:@"results"];
        
        for (NSDictionary *eventDict in resultArray)
        {
            EventRegistrant *reg = [EventRegistrant eventRegistrantWithDictionary:eventDict];
            [eventArray addObject:reg];
        }
        NSDictionary *meta = [response.data objectForKey:@"meta"];
        ResultSet *resultSet = [[ResultSet alloc] initResultSetWithResults:[eventArray copy] andMeta:meta];
        
        [response replaceDataWithNewData:resultSet];
    }
    return response;
}

#pragma mark - individual event registrant

+ (HttpResponse *)getEventRegistrantWithAccessToken:(NSString*)accessToken withEventId:(NSString *)eventId andRegistrantId:(NSString *)registrantId
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"event_spot_individual_registration"],eventId,registrantId];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@",accessToken , apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken]];
    
    if (response.statusCode == 200)
    {
        EventRegistrantExtended *registrant = [EventRegistrantExtended eventRegistrantExtendedWithDictionary:response.data];
        [response replaceDataWithNewData:registrant];
    }
    return response;
}

#pragma mark - event Item collection

+ (HttpResponse *)getEventItemCollectionWithAccessToken:(NSString*)accessToken withEventId:(NSString *)eventId
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"event_spot_event_item_collection"],eventId];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@",accessToken , apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken]];
    
    if (response.statusCode == 200)
    {
        NSMutableArray *itemArray = [[NSMutableArray alloc] init];
        
        for (NSDictionary *eventDict in response.data)
        {
            EventItem *item = [EventItem eventItemWithDictionary:eventDict];
            [itemArray addObject:item];
        }
        [response replaceDataWithNewData:itemArray];
    }
    return response;
}
+ (HttpResponse *)addEventItemWithAccesToken:(NSString*)accessToken withEventId:(NSString *)eventId  andItem:(EventItem *)item
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"event_spot_event_item_collection"],eventId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *eventFeeExtendedJson = [item JSON];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest postWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken] andStringData:eventFeeExtendedJson];
    
    if (response.statusCode == 201)
    {
        EventItem *item = [EventItem eventItemWithDictionary:response.data];
        [response replaceDataWithNewData:item];
    }
    return response;
}

#pragma mark - individual event Item

+ (HttpResponse *)getEventItemWithAccessToken:(NSString*)accessToken withEventId:(NSString *)eventId andItemId:(NSString *)itemId
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"event_spot_individual_event_item"],eventId,itemId];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@",accessToken , apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken]];
    
    if (response.statusCode == 200)
    {
        EventItem *item = [EventItem eventItemWithDictionary:response.data];
        [response replaceDataWithNewData:item];
    }
    return response;
}

+ (HttpResponse *)updateEventItemWithAccessToken:(NSString*)accessToken withEventId:(NSString *)eventId itemId:(NSString *)itemId andItem:(EventItem *)item
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"event_spot_individual_event_item"],eventId,itemId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *eventFeeExtendedJson = [item JSON];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest putWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken] andStringData:eventFeeExtendedJson];
    
    if (response.statusCode == 200)
    {
        EventItem *item = [EventItem eventItemWithDictionary:response.data];
        [response replaceDataWithNewData:item];
    }
    return response;
}

+ (BOOL)deleteEventItemWithAccessToken:(NSString*)accessToken withEventId:(NSString *)eventId andItemId:(NSString *)itemId errors:(NSArray *__autoreleasing *)errors;
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"event_spot_individual_event_item"],eventId,itemId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest deleteWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken]];
    
    *errors = response.errors;
    
    return (response.statusCode == 204);
}

#pragma mark - event Item attribute collection

+ (HttpResponse *)getEventItemAttributeCollectionWithAccessToken:(NSString*)accessToken withEventId:(NSString *)eventId andItemId:(NSString *)itemId
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"event_spot_item_attribute_collection"],eventId,itemId];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@",accessToken , apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken]];
    
    if (response.statusCode == 200)
    {
        NSMutableArray *atrArray = [[NSMutableArray alloc] init];
        
        for (NSDictionary *eventDict in response.data)
        {
            EventItemAttribute *attr = [EventItemAttribute itemAttributeWithDictionary:eventDict];
            [atrArray addObject:attr];
        }
        [response replaceDataWithNewData:atrArray];
    }
    return response;
}

+ (HttpResponse *)addEventItemAttributeWithAccesToken:(NSString*)accessToken withEventId:(NSString *)eventId itemId:(NSString *)itemId andItemAttribute:(EventItemAttribute *)itemAttribute
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"event_spot_item_attribute_collection"],eventId,itemId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *eventFeeExtendedJson = [itemAttribute JSON];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest postWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken] andStringData:eventFeeExtendedJson];
    
    if (response.statusCode == 201)
    {
        EventItemAttribute *attr = [EventItemAttribute itemAttributeWithDictionary:response.data];
        [response replaceDataWithNewData:attr];
    }
    return response;
}

#pragma mark - individual event Item attribute

+ (HttpResponse *)getEventItemAttributeWithAccessToken:(NSString*)accessToken withEventId:(NSString *)eventId itemId:(NSString *)itemId andAttributeId:(NSString *)attributeId
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"event_spot_individual_item_attribute"],eventId,itemId,attributeId];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@",accessToken , apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken]];
    
    if (response.statusCode == 200)
    {
        EventItemAttribute *itemAttr = [EventItemAttribute itemAttributeWithDictionary:response.data];
        [response replaceDataWithNewData:itemAttr];
    }
    return response;
}

+ (HttpResponse *)updateEventItemAttributeWithAccessToken:(NSString*)accessToken withEventId:(NSString *)eventId itemId:(NSString *)itemId attributeId:(NSString *)attributeId andAttribute:(EventItemAttribute *)itemAttribute
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"event_spot_individual_item_attribute"],eventId,itemId,attributeId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *eventFeeExtendedJson = [itemAttribute JSON];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest putWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken] andStringData:eventFeeExtendedJson];
    
    if (response.statusCode == 200)
    {
        EventItemAttribute *attr = [EventItemAttribute itemAttributeWithDictionary:response.data];
        [response replaceDataWithNewData:attr];
    }
    return response;
}

+ (BOOL)deleteEventItemAttributeWithAccessToken:(NSString*)accessToken withEventId:(NSString *)eventId itemId:(NSString *)itemId andAttributeId:(NSString *)attributeId errors:(NSArray *__autoreleasing *)errors
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint =[NSString stringWithFormat:[Config valueForType:@"endpoints" key:@"event_spot_individual_item_attribute"],eventId,itemId,attributeId];
    
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest deleteWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken]];
    
    *errors = response.errors;
    
    return (response.statusCode == 204);
}

@end