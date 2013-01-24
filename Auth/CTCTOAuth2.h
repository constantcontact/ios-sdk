//
//  CTCTOAuth2.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTCTOAuth2 : NSObject
{
    NSArray *cookiesArray;
}

@property (nonatomic, assign) NSString *clientID;
@property (nonatomic, assign) NSString *clientSecret;
@property (nonatomic, assign) NSString *redirectURI;
@property (nonatomic, assign) NSString *userName;
@property (nonatomic, assign) NSString *password;

 /**
 * Function that initializes a CTCTOAuth2 object with the user information;
 *
 * @param NSString* clientID - the id of the user selected app;
 * @paran NSString* redirectURI - the redirect uri related to the clientId;
 * @paran NSString* userName - the name of the user;
 * @paran NSString* password - the password of the user;
 */
- (id)initWithClientID:(NSString*)clientID redirectURI:(NSString*)redirectURI userName:(NSString*)userName password:(NSString*)password;

 /**
 * Function forms the URL at which the user can authenticate and authorize the requesting application;
 *
 * @param BOOL server - paramater that determines if the response type;
 *
 * @return NSString* - URL at which the user can authenticate and authorize the requesting application;
 */
- (NSString*) authorizationURLFromServer:(BOOL)server;

 /**
 * Function that returns the access token from the site when the user gives a intermediary code;
 *
 * @param NSString* code - code sent to site and obtained at login;
 *
 * @return NSDictionary* - a dictinary that contains the accesToken;
 */
- (NSDictionary*)accesTokenWithCode:(NSString*)code;

 /** 
 * Function is used to obtain an access token;
 *
 * @return NSString* - access token returned from constant contact after a user has granted access to their account;
 */
- (NSString*) accessToken;

 /**
 * Function is used to return the username of the user who authorized the application;
 *
 * @param NSString* accessToken - Constant Contact OAuth2 access token, obtained after login;
 *
 * @return NSString* - the userName of the user authenthicated by the token;
 */
- (NSString *)userNameForAppOwner:(NSString *)token;

@end
