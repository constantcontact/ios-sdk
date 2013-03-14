//
//  VeriffiedEmailAddresses.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "VeriffiedEmailAddresses.h"

@implementation VeriffiedEmailAddresses

+ (NSDictionary *)getEmailAddresses:(NSString *)accessToken andConfirmedStatus:(NSString *)status
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
    
    NSDictionary *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    NSMutableDictionary *sendBack = [[NSMutableDictionary alloc]init];
    if([response objectForKey:@"ERROR"])
        return response;
    else
    {
        NSMutableArray *verifiedEmails =  [response objectForKey:@"result"];
        [sendBack setObject:verifiedEmails forKey:@"data"];
    }
    
    return [sendBack mutableCopy];
}

@end
