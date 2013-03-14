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
    TestSend *testSend = [[TestSend alloc] init];
    
    testSend.format = [Component valueForDictionary:dictionary withKey:@"format"];
    testSend.personalMessage = [Component valueForDictionary:dictionary withKey:@"personal_message"];
    
    testSend.emailAddresses = [[NSMutableArray alloc] init];
    
    for(NSString *emailAddress in [dictionary objectForKey:@"email_addresses"])
    {
        [testSend.emailAddresses addObject:emailAddress];
    }
    
    return testSend;
}

- (void)addEmailToEmailAddresses:(NSString *)emailAddress
{
    [_emailAddresses addObject:emailAddress];
}

-(id) proxyForJson
{
    return [NSDictionary dictionaryWithObjectsAndKeys:   _format , @"format",_personalMessage , @"personal_message",_emailAddresses , @"email_addresses",nil];
}

- (NSString *) toJson
{
    NSString *jsonDict = [self proxyForJson];
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
