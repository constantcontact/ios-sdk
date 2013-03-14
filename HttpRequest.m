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
+(NSDictionary*)getWithUrl:(NSString*)url andHeaders:(NSArray*)headers
{
    return [self httpRequestWithUrl:url andMethod:@"GET" andHeaders:headers andStringData:nil];
}

// ----------------------------------------------------------------------------------------------------
// Make an Http POST request
// url - request url
// headers - array of all http headers to send
// stringData - stringData to send with request
// ----------------------------------------------------------------------------------------------------
+(NSDictionary*)postWithUrl:(NSString*)url andHeaders:(NSArray*)headers andStringData:(NSString*)stringData
{
    return [self httpRequestWithUrl:url andMethod:@"POST" andHeaders:headers andStringData:stringData];
}

// ----------------------------------------------------------------------------------------------------
// Make an Http PUT request
// url - request url
// headers - array of all http headers to send
// stringData - stringData to send with request
// ----------------------------------------------------------------------------------------------------
+ (NSDictionary*)putWithUrl:(NSString*)url andHeaders:(NSArray*)headers andStringData:(NSString*)stringData
{
    return [self httpRequestWithUrl:url andMethod:@"PUT" andHeaders:headers andStringData:stringData];
}

// ----------------------------------------------------------------------------------------------------
// Make an Http DELETE request
// url - request url
// headers - array of all http headers to send
// data - data to send with request
// ----------------------------------------------------------------------------------------------------
+(NSDictionary*)deleteWithUrl:(NSString*)url andHeaders:(NSArray*)headers
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
+(NSDictionary*)httpRequestWithUrl:(NSString*)url andMethod:(NSString*)method andHeaders:(NSArray*)headers andStringData:(NSString*)stringData
{
    NSError *error=nil;
    NSString *text = nil;
  
    // Post data on server
    NSMutableData *postData = [NSMutableData data];
    NSURLResponse* response = nil;
  
    //--------------headers shuld be placed in headers if they are here
    NSString *params =[[NSString alloc]init];//[NSString stringWithFormat:@"%@ %@ %@", [headers objectAtIndex:0], [headers objectAtIndex:1], [headers objectAtIndex:2] ];
       if (stringData)
          params = [params stringByAppendingString:stringData];
    
      [postData appendData:[params dataUsingEncoding: NSUTF8StringEncoding]];
    
    // Request
    NSMutableURLRequest *urlRequest;
    urlRequest = [[NSMutableURLRequest alloc] init];
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
    text = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
   
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    NSString *responseStatusCode =[NSString stringWithFormat:@"%d", [httpResponse statusCode]];
    NSLog(@"STATUS CODE: %@ MESSAGE:%@",responseStatusCode,text);
    id responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
    
   //---------json may return dictionary or array classes have to check;
    NSMutableDictionary *resultDictionary = nil;
    if([responseJSON isKindOfClass:[NSArray class]])
    {
        if([responseJSON count] > 0)
        {
            if([[responseJSON objectAtIndex:0] objectForKey:@"error_key"])
            {
                NSLog(@"ErrorKey: %@ - ErrorMessage: %@", [[responseJSON objectAtIndex:0] objectForKey:@"error_key"], [[responseJSON objectAtIndex:0] objectForKey:@"error_message"]);
                
                resultDictionary = [[NSMutableDictionary alloc]init];
                [resultDictionary setObject:[responseJSON objectAtIndex:0] forKey:@"ERROR"];
                
                return resultDictionary;
            }
            
            resultDictionary = [[NSMutableDictionary alloc]init];
            [resultDictionary setObject:responseJSON forKey:@"result"];
        }
    }
    if ([responseJSON isKindOfClass:[NSDictionary class]])
    {
       if([responseJSON objectForKey:@"error_key"])
       {
         NSLog(@"ErrorKey: %@ - ErrorMessage: %@", [responseJSON objectForKey:@"error_key"], [responseJSON objectForKey:@"error_message"]);
           
           resultDictionary = [[NSMutableDictionary alloc]init];
           [resultDictionary setObject:[responseJSON objectAtIndex:0] forKey:@"ERROR"];
           
           return resultDictionary;
           
         return nil;
       }
        resultDictionary = responseJSON;
    }
    if (!responseJSON)
    {
        resultDictionary = [[NSMutableDictionary alloc]init];
        [resultDictionary setObject:@"204" forKey:@"code"];
    }
    return [resultDictionary mutableCopy];
}

@end
