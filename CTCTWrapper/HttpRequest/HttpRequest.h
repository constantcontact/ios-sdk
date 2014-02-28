//
//  HttpRequest.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpResponse.h"

@interface HttpRequest : NSObject
 /**
 * Function is used to make a Http GET request;
 *
 *  @param NSString* Url - the request url for the call;
 *  @param NSArray* Headers - a array of all http headers to send;
 *  
 *  @return HttpResponse* - The function returns a response that contains the calls returned value;
 */
 +(HttpResponse*)getWithUrl:(NSString*)url andHeaders:(NSArray*)headers;

 /**
  * Function is used to make a Http POST request;
  *
  *  @param NSString* Url - the request url for the call;
  *  @param NSArray* Headers - a array of all http headers to send;
  *  @param NSString* stringData - aditional data to send with request;
  *
  *  @return HttpResponse* - The function returns a response that contains the calls returned value;
  */
+(HttpResponse*)postWithUrl:(NSString*)url andHeaders:(NSArray*)headers andStringData:(NSString*)stringData;

 /**
 * Function is used to make a Http PUT request;
 *
 *  @param NSString* Url - the request url for the call;
 *  @param NSArray* Headers - a array of all http headers to send;
 *  @param NSString* stringData - aditional data to send with request;
 *
 *  @return HttpResponse* - The function returns a response that contains the calls returned value;
 */
+(HttpResponse*)putWithUrl:(NSString*)url andHeaders:(NSArray*)headers andStringData:(NSString*)stringData;

/**
 * Function is used to make a Http PATCH request;
 *
 *  @param NSString* Url - the request url for the call;
 *  @param NSArray* Headers - a array of all http headers to send;
 *  @param NSString* stringData - aditional data to send with request;
 *
 *  @return HttpResponse* - The function returns a response that contains the calls returned value;
 */
+(HttpResponse*)patchWithUrl:(NSString*)url andHeaders:(NSArray*)headers andStringData:(NSString*)stringData;

 /**
 * Function is used to make a Http DELETE request;
 *
 *  @param NSString* Url - the request url for the call;
 *  @param NSArray* Headers - a array of all http headers to send;
 *  @param NSString* stringData - aditional data to send with request;
 *
 *  @return HttpResponse* - The function returns a response that contains the calls returned value;
 */
+(HttpResponse*)deleteWithUrl:(NSString*)url andHeaders:(NSArray*)headers;

 /**
 * Function is used to make a Http request;
 *
 *  @param NSString* Url - the request url for the call;
 *  @param NSArray* Headers - a array of all http headers to send;
 *  @param NSString* StringData - aditional data to send with request;
 *  @param NSString* Method - the method type of the request ( PUT, GET, DELETE, etc.);
 *
 *  @return HttpResponse* - The function returns a response that contains the calls returned value;
 */
+(HttpResponse*)httpRequestWithUrl:(NSString*)url andMethod:(NSString*)method andHeaders:(NSArray*)headers andStringData:(NSString*)stringData;

/**
 * Function is used to make a Http multipart request for bulk activityes;
 *
 *  @param NSString* Url - the request url for the call;
 *  @param NSString* fileName - the filename of the file sent to the server (first part of the multipart);
 *  @param NSString* data - the data from the selected file in string format (second part of the multipart);
 *  @param NSString* lists - a string containing the lists where the contacts will be added;
 *
 *  @return HttpResponse* - The function returns a response that contains the calls returned value;
 */
+ (HttpResponse*)httpMultipartRequestWithUrl:(NSString *)urlString file:(NSString *)fileName data:(NSData *)data lists:(NSString *)lists;

/**
 * Function is used to make a Http multipart request for MyLibrary files;
 *
 *  @param NSString* Url - the request url for the call;
 *  @param NSString* fileName - the filename of the file sent to the server;
 *  @param NSString* folderId
 *  @param NSString* description
 *  @param NSString* source
 *  @param NSString* data - the data from the selected file in string format (second part of the multipart);
 *
 *  @return HttpResponse* - The function returns a response that contains the calls returned value;
 */
+ (HttpResponse*)httpMultipartRequestWithUrl:(NSString *)urlString file:(NSString *)fileName folderId:(NSString *)folderId description:(NSString *)description source:(NSString *)source data:(NSData *)data;
@end
