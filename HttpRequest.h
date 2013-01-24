//
//  HttpRequest.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpRequest : NSObject

 /**
 * Function is used to make a Http GET request;
 *
 *  @param NSString* Url - the request url for the call;
 *  @param NSArray* Headers - a array of all http headers to send;
 *  
 *  @return NSDictionary* -The function returns a dictionary that contains the calls returned value;
 */
 +(NSDictionary*)getWithUrl:(NSString*)url andHeaders:(NSArray*)headers;

 /**
  * Function is used to make a Http POST request;
  *
  *  @param NSString* Url - the request url for the call;
  *  @param NSArray* Headers - a array of all http headers to send;
  *  @param NSString* stringData - aditional data to send with request;
  *
  *  @return NSDictionary* -The function returns a dictionary that contains the calls returned value;
  */
+(NSDictionary*)postWithUrl:(NSString*)url andHeaders:(NSArray*)headers andStringData:(NSString*)stringData;

 /**
 * Function is used to make a Http PUT request;
 *
 *  @param NSString* Url - the request url for the call;
 *  @param NSArray* Headers - a array of all http headers to send;
 *  @param NSString* stringData - aditional data to send with request;
 *
 *  @return NSDictionary* -The function returns a dictionary that contains the calls returned value;
 */
+(NSDictionary*)putWithUrl:(NSString*)url andHeaders:(NSArray*)headers andStringData:(NSString*)stringData;

 /**
 * Function is used to make a Http DELETE request;
 *
 *  @param NSString* Url - the request url for the call;
 *  @param NSArray* Headers - a array of all http headers to send;
 *  @param NSString* stringData - aditional data to send with request;
 *
 *  @return NSDictionary* -The function returns a dictionary that contains the calls returned value;
 */
+(NSDictionary*)deleteWithUrl:(NSString*)url andHeaders:(NSArray*)headers;

 /**
 * Function is used to make a Http request;
 *
 *  @param NSString* Url - the request url for the call;
 *  @param NSArray* Headers - a array of all http headers to send;
 *  @param NSString* StringData - aditional data to send with request;
 *  @param NSString* Method - the method type of the request ( PUT, GET, DELETE, etc.);
 *
 *  @return NSDictionary* -The function returns a dictionary that contains the calls returned value;
 */
+(NSDictionary*)httpRequestWithUrl:(NSString*)url andMethod:(NSString*)method andHeaders:(NSArray*)headers andStringData:(NSString*)stringData;

@end
