//
//  Collection.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "Collection.h"

@implementation Collection

// ----------------------------------------------------------------------------------------------------
// Helper function to return required headers for making an http request with constant contact
// accessToken - OAuth2 access token to be placed into the Authorization header
// ----------------------------------------------------------------------------------------------------
+(NSArray*)headersWithAccessToken:(NSString*)accessToken
{
    return [NSArray arrayWithObjects:@"Content-Type: application/json", @"Accept: application/json", [NSString stringWithFormat:@"Authorization: Bearer %@", accessToken], nil];
}           

@end
