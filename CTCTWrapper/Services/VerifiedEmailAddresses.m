//
//  VeriffiedEmailAddresses.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "VerifiedEmailAddresses.h"

@implementation VerifiedEmailAddresses

+ (HttpResponse *)getEmailAddresses:(NSString *)accessToken andConfirmedStatus:(NSString *)status
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"verified_email"];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
 
    if([status isEqualToString:@"UNCONFIRMED"])
            httpQuery = [NSString stringWithFormat:@"%@&status=%@",httpQuery,@"UNCONFIRMED"];
    else if ([status isEqualToString:@"CONFIRMED"])
             httpQuery = [NSString stringWithFormat:@"%@&status=%@",httpQuery,@"CONFIRMED"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:[HttpRequest headersWithAccessToken:accessToken]];
    
    if (response.statusCode == 200)
    {
        NSArray *resultArray = response.data;
        NSMutableArray *emails = [[NSMutableArray alloc] init];
        
        for (NSDictionary* emailDict in resultArray)
        {
            EmailAddress *email = [EmailAddress emailAddressWithDictionary:emailDict];
            [emails addObject:email];
        }
        
        [response replaceDataWithNewData:[emails copy]];
    }
    
    return response;
}

@end
