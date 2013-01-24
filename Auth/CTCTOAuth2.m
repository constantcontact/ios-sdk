//
//  CTCTOAuth2.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "CTCTOAuth2.h"
#import "Config.h"
#import "HttpRequest.h"

@implementation CTCTOAuth2

- (id)initWithClientID:(NSString*)clientID redirectURI:(NSString*)redirectURI userName:(NSString*)userName password:(NSString*)password
{
    if (self = [super init])
    {
        self.clientID = clientID;
        self.clientSecret = @"";
        self.redirectURI = redirectURI;
        self.userName = userName;
        self.password = password;
        
        cookiesArray = [[NSArray alloc] init];
    }
    
    return self;
}

// -------------------------------------------------------------------------------------------------
// Get the URL at which the user can authenticate and authorize the requesting application
// -------------------------------------------------------------------------------------------------
- (NSString*)authorizationURLFromServer:(BOOL)server
{
    NSString *stringParams = [NSString stringWithFormat:@"response_type=%@&client_id=%@&redirect_uri=%@",server ? [Config valueForType:@"auth" key:@"response_type_code"] : [Config valueForType:@"auth" key:@"response_type_token"], self.clientID, self.redirectURI];
    
    NSString *baseURL = [Config valueForType:@"auth" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"auth" key:@"authorization_endpoint"];
    NSString *httpQuery = [NSString stringWithFormat:@"%@", stringParams];
    
    NSString *authURL = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    return authURL;
}


// Get accessToken
-(NSString*) accessToken
{
    // Access the authorization URL
    NSString *url = [self authorizationURLFromServer:NO];
    NSLog(@"URL1:%@", url);
    
    NSDictionary *response = [self httpRequestWithUrl:url andMethod:@"GET"];
    NSString * responseStatusCode = [response objectForKey:@"ResponseStatusCode"];
    
    if ([responseStatusCode isEqualToString:@"200"]) // statusCode=200
    {
        // Construct the login URL
        NSString *baseURL = [Config valueForType:@"login" key:@"base_url"];
        NSString *encoding = [NSString stringWithFormat:@"%@%@?response_type=%@", [Config valueForType:@"auth" key:@"base_url"], [Config valueForType:@"login" key:@"login_endpoint"], [Config valueForType:@"auth" key:@"response_type_token"]];
        NSString *httpQuery = [NSString stringWithFormat:@"reauth=false&gotoUrl=%@&cookiesEnabled=true&luser=%@&lpass=%@&_remuser=on&_save=", encoding, self.userName, self.password];

        url = [NSString stringWithFormat:@"%@?%@", baseURL, httpQuery];
        NSLog(@"URL2:%@", url);
        
        response = [self httpRequestWithUrl:url andMethod:@"POST"];
        responseStatusCode = [response objectForKey:@"ResponseStatusCode"];
        
        if ([responseStatusCode isEqualToString:@"200"]) // statusCode=200
        {
            
            // Grant access to redirect URL
            baseURL = [Config valueForType:@"auth" key:@"base_url"];
            encoding = [NSString stringWithFormat:@"%@?user_oauth_approval=true&preregistered_redirect_uri=%@", [Config valueForType:@"auth" key:@"authorization_endpoint"], self.redirectURI];
            
            url = [NSString stringWithFormat:@"%@%@", baseURL, encoding];
            NSLog(@"URL3:%@", url);
            
            response = [self httpRequestWithUrl:url andMethod:@"POST"];
            responseStatusCode = [response objectForKey:@"ResponseStatusCode"];
            
            if ([responseStatusCode isEqualToString:@"200"]) // statusCode=200
            {
                NSString *responseURL = [response objectForKey:@"ResponseURL"];
                NSRange range = [responseURL rangeOfString:@"#access_token="];
                
                if (range.location != NSNotFound)
                {
                    NSString *accessToken= [responseURL substringFromIndex:range.location + 14];
                    accessToken = [accessToken substringToIndex:36];
                    
                    return accessToken;
                }
            }
        }
    }
    
    return nil;
}


-(NSDictionary*)httpRequestWithUrl:(NSString*)url andMethod:(NSString*)method
{
    NSError *error = nil;
    NSURLResponse *response = nil;
    
    // Request
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [urlRequest setHTTPMethod:method];

    if (cookiesArray)
    {
        for (NSHTTPCookie *cookieee in cookiesArray)
            [urlRequest setValue:[NSString stringWithFormat:@"%@",cookieee] forHTTPHeaderField:@"Cookies"];
    }

    NSData *responseData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int responseStatusCode = [httpResponse statusCode];
    NSString *responseURL = [NSString stringWithFormat:@"%@", [httpResponse URL]];
    
    NSLog(@"STATUS:%d", responseStatusCode);
    NSLog(@"URLRESPONSE:%@", responseURL);
    
    NSDictionary *theHeaders = [httpResponse allHeaderFields];
    NSString * cookie = [theHeaders valueForKey:@"Set-Cookie"];
    
    if (cookie)
        cookiesArray = [NSHTTPCookie cookiesWithResponseHeaderFields:theHeaders forURL:[response URL]];   

    return [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d", responseStatusCode], @"ResponseStatusCode", responseURL, @"ResponseURL",  nil];
}


// ----------------------------------------------------------------------------------------------------
// Obtain an access token
// code - code returned from Constant Contact after a user has granted access to their account
// ----------------------------------------------------------------------------------------------------
- (NSDictionary*)accesTokenWithCode:(NSString*)code
{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [Config valueForType:@"auth" key:@"authorization_code_grant_type"] , @"grant_type",
                            self.clientID, @"client_id",
                            self.clientSecret, @"client_secret",
                            code, @"code",
                            self.redirectURI, @"redirect_uri"
                            , nil];
    
    NSString *baseURL = [Config valueForType:@"auth" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"auth" key:@"authorization_endpoint"];
    NSString *httpQuery = [NSString stringWithFormat:@"%@", params];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    NSDictionary *responseJSON = [HttpRequest postWithUrl:url andHeaders:nil andStringData:nil];
    
    return responseJSON;
}
//----------------------------------------------------------------------------------------------------------------------
//Returns the username of the user who authorized the application
//----------------------------------------------------------------------------------------------------------------------
-(NSString *)userNameForAppOwner:(NSString *)token
{
    NSString *url = @"https://oauth2.constantcontact.com/oauth2/tokeninfo.htm";
   
    // Post data on server
    NSMutableData *postData = [NSMutableData data];
    NSURLResponse* response = nil;
    
    //--------------headers shuld be placed in headers if they are here
    NSString *params =[[NSString alloc]init];
    params = [params stringByAppendingString:[NSString stringWithFormat:@"access_token=%@",token]];
    
    [postData appendData:[params dataUsingEncoding: NSUTF8StringEncoding]];
    
    // Request
    NSMutableURLRequest *urlRequest;
    urlRequest = [[NSMutableURLRequest alloc] init];
    [urlRequest setURL:[NSURL URLWithString:url]];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setValue:[NSString stringWithFormat:@"%d", [postData length]] forHTTPHeaderField:@"Content-Length"];
    [urlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setHTTPBody:postData];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:nil];
    NSString *text = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    NSString *responseStatusCode =[NSString stringWithFormat:@"%d", [httpResponse statusCode]];
    NSLog(@"STATUS CODE: %@ TEXT:%@",responseStatusCode,text);
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
    
    return [responseJSON objectForKey:@"user_name"];
}

@end
