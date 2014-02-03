//
//  TestSend.m
//  ConstantContact
//
//  Copyright (c) 2013 ConstantContact. All rights reserved.
//

#import "TestSend.h"

@implementation TestSend

- (id)init
{
    if (self = [super init])
    {
        _format = @"";
        _personalMessage = @"";
        _emailAddresses = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _format = [Component valueForDictionary:dictionary withKey:@"format"];
        _personalMessage = [Component valueForDictionary:dictionary withKey:@"personal_message"];
        
        _emailAddresses = [[NSMutableArray alloc] init];
        
        
        for(NSString *emailAddress in [dictionary objectForKey:@"email_addresses"])
        {
            [_emailAddresses addObject:emailAddress];
        }
    }
    return self;
}

+ (TestSend *)testSendWithDictionary:(NSDictionary *)dictionary
{
    TestSend *testSend = [[TestSend alloc] initWithDictionary:dictionary];
    
    return testSend;
}

- (void)addEmailToEmailAddresses:(NSString *)emailAddress
{
    [_emailAddresses addObject:emailAddress];
}

- (NSDictionary*)proxyForJSON
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            _format , @"format",
            _personalMessage , @"personal_message",
            _emailAddresses , @"email_addresses",
            nil];
}

- (NSString*)JSON
{
    NSDictionary *jsonDict = [self proxyForJSON];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *jsonString = @"";
    
    if (!jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    return jsonString;
}

@end
