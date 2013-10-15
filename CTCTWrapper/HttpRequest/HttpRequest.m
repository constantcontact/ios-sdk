//
//  HttpRequest.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "HttpRequest.h"

#import "Config.h"

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
//
// ----------------------------------------------------------------------------------------------------
+ (HttpResponse*)httpMultipartRequestWithUrl:(NSString *)urlString file:(NSString *)fileName data:(NSData *)data lists:(NSString *)lists;
{
    return [self httpMultipartRequestWithUrl:urlString file:fileName data:data lists:lists andMethod:@"POST"];
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

+ (HttpResponse*)httpMultipartRequestWithUrl:(NSString *)urlString file:(NSString *)fileName data:(NSData *)data lists:(NSString *)lists andMethod:(NSString *)method
{
    HttpResponse *customResponse = nil;
    NSURLResponse* response = nil;
    NSError *error = nil;
    
    NSString *boundary = @"------------------------------------14737809831466499882746641449";
    
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:method];
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    //file name
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"file_name"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@\r\n", fileName] dataUsingEncoding:NSUTF8StringEncoding]];
    //lists
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"lists"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@\r\n", lists] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //contacts
    NSString *extension = [self contentMimeType:fileName];
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n", @"data"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n\r\n",extension] dataUsingEncoding:NSUTF8StringEncoding]];
                      
    //[body appendData:[data dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:data];
    [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%d", [body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    // set URL
    [request setURL:[NSURL URLWithString:urlString]];
    
    // NSString *postLength = [NSString stringWithFormat:@"%d", [body length]];
    // [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    // NSLog(@"%@", [[NSString alloc] initWithUTF8String:[body bytes]]);
    // NSLog(@"%@", [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding]);
    // NSLog(@"%@", [urlRequest valueForHTTPHeaderField:@"Content-Type"]);
    NSLog(@"%@", [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding]);
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int responseStatusCode = httpResponse.statusCode;
    id responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
    NSString *responseURL = [NSString stringWithFormat:@"%@", [httpResponse URL]];
    
    NSDictionary *responseDictionary;
    
    // json may return dictionary or array classes have to check
    if (responseStatusCode == 200 || responseStatusCode == 204 || responseStatusCode == 201)
    {
        responseDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                              urlString, KEY_REQUEST_URL,
                              responseURL, KEY_RESPONSE_URL,
                              [NSNumber numberWithInt:responseStatusCode], KEY_STATUS_CODE,
                              responseJSON, KEY_DATA,
                              nil];
        
        customResponse = [[HttpResponse alloc] initWithDictionary:responseDictionary];
    }
    else
    {
        responseDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                              urlString, KEY_REQUEST_URL,
                              responseURL, KEY_RESPONSE_URL,
                              [NSNumber numberWithInt:responseStatusCode], KEY_STATUS_CODE,
                              responseJSON, KEY_ERRORS,
                              nil];
        
        customResponse = [[HttpResponse alloc] initWithDictionary:responseDictionary];
    }
    return customResponse;
}

+ (NSString *)contentMimeType:(NSString *)fileName
{
    NSArray *arr = [fileName componentsSeparatedByString:@"."];
    NSString *extension = [arr.lastObject uppercaseString];
    
    NSString *mime = @"";
    if([extension isEqualToString:@"TXT"])
    {
         mime = @"text/plain";
    }
    else if([extension isEqualToString:@"CSV"])
    {
        mime = @"text/csv";
    }
    else if([extension isEqualToString:@"XLS"])
    {
        mime = @"application/vnd.ms-excel";
    }
    else if([extension isEqualToString:@"XLSX"])
    {
         mime = @"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
    }
    return mime;
}
@end
