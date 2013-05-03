//
//  HttpRequest.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "HttpRequest.h"

@implementation HttpRequest

// ----------------------------------------------------------------------------------------------------
// Make an Http GET request
// url - request url
// headers - array of all http headers to send
// ----------------------------------------------------------------------------------------------------
+(HttpResponse*)getWithUrl:(NSString*)url andHeaders:(NSArray*)headers
{
    return [self httpRequestWithUrl:url andMethod:@"GET" andHeaders:headers andStringData:nil];
}

// ----------------------------------------------------------------------------------------------------
// Make an Http POST request
// url - request url
// headers - array of all http headers to send
// stringData - stringData to send with request
// ----------------------------------------------------------------------------------------------------
+(HttpResponse*)postWithUrl:(NSString*)url andHeaders:(NSArray*)headers andStringData:(NSString*)stringData
{
    return [self httpRequestWithUrl:url andMethod:@"POST" andHeaders:headers andStringData:stringData];
}

// ----------------------------------------------------------------------------------------------------
// Make an Http PUT request
// url - request url
// headers - array of all http headers to send
// stringData - stringData to send with request
// ----------------------------------------------------------------------------------------------------
+ (HttpResponse*)putWithUrl:(NSString*)url andHeaders:(NSArray*)headers andStringData:(NSString*)stringData
{
    return [self httpRequestWithUrl:url andMethod:@"PUT" andHeaders:headers andStringData:stringData];
}

// ----------------------------------------------------------------------------------------------------
// Make an Http DELETE request
// url - request url
// headers - array of all http headers to send
// data - data to send with request
// ----------------------------------------------------------------------------------------------------
+(HttpResponse*)deleteWithUrl:(NSString*)url andHeaders:(NSArray*)headers
{
    return [self httpRequestWithUrl:url andMethod:@"DELETE" andHeaders:headers andStringData:nil];
}

// ----------------------------------------------------------------------------------------------------
// Make an Http request
// url - request url
// headers - array of all http headers to send
// stringData - stringData to send with the request
// method - the method type of the call (put, get,delete, etc.)
// ----------------------------------------------------------------------------------------------------
+(HttpResponse*)httpRequestWithUrl:(NSString*)url andMethod:(NSString*)method andHeaders:(NSArray*)headers andStringData:(NSString*)stringData
{
    NSError *error = nil;
    HttpResponse *customResponse = nil;
  
    // Post data on server
    NSMutableData *postData = [NSMutableData data];
    NSURLResponse* response = nil;
  
    //--------------headers shuld be placed in headers if they are here
    NSString *params = [[NSString alloc] init];
       if (stringData)
          params = [params stringByAppendingString:stringData];
    
      [postData appendData:[params dataUsingEncoding: NSUTF8StringEncoding]];
    
    // Request
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] init];
    [urlRequest setURL:[NSURL URLWithString:url]];
    [urlRequest setHTTPMethod:method];
    [urlRequest setValue:[NSString stringWithFormat:@"%d", [postData length]] forHTTPHeaderField:@"Content-Length"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    if(headers.count > 0)
    {
        NSString *authorization = [NSString stringWithFormat:@"Bearer %@",[headers objectAtIndex:0]];
        [urlRequest setValue:authorization forHTTPHeaderField:@"Authorization"];
    }
    
    [urlRequest setHTTPBody:postData];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
   
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int responseStatusCode = httpResponse.statusCode;
    id responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
    NSString *responseURL = [NSString stringWithFormat:@"%@", [httpResponse URL]];
    
    NSDictionary *responseDictionary;
    
    // json may return dictionary or array classes have to check
    if (responseStatusCode == 200 || responseStatusCode == 204 || responseStatusCode == 201)
    {
        responseDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                              url, KEY_REQUEST_URL,
                              responseURL, KEY_RESPONSE_URL,
                              [NSNumber numberWithInt:responseStatusCode], KEY_STATUS_CODE,
                              responseJSON, KEY_DATA,
                              nil];
        
        customResponse = [[HttpResponse alloc] initWithDictionary:responseDictionary];
    }
    else
    {
        responseDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                              url, KEY_REQUEST_URL,
                              responseURL, KEY_RESPONSE_URL,
                              [NSNumber numberWithInt:responseStatusCode], KEY_STATUS_CODE,
                              responseJSON, KEY_ERRORS,
                              nil];
        
        customResponse = [[HttpResponse alloc] initWithDictionary:responseDictionary];
    }
    
    return customResponse;
}

@end
