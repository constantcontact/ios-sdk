//
//  Collection.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Collection : NSObject

/**
    * Helper function to return required headers for making an http request with constant contact
    *
    * @param NSString* accessToken - OAuth2 access token to be placed into the Authorization header
*/
+(NSArray*)headersWithAccessToken:(NSString*)accessToken;

@end
