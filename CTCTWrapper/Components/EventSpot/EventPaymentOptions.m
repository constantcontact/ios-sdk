//
//  EventPaymentOptions.m
//  CTCTContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "EventPaymentOptions.h"

@implementation EventPaymentOptions

- (id)init
{
    if (self = [super init])
    {
        _eventPaymentTypeEnum= [[EventPaymentTypeEnum alloc]init];
        
        _paymentTypes = @"";
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _eventPaymentTypeEnum= [[EventPaymentTypeEnum alloc]init];
        
        _paymentTypes = [Component valueForDictionary:dictionary withKey:@"payment_types"];
    }
    
    return self;
}

+ (EventPaymentOptions *)eventPaymentOptionsWithDictionary:(NSDictionary *)dictionary
{
    EventPaymentOptions *options = [[EventPaymentOptions alloc] initWithDictionary:dictionary];
    
    return options;
}

-(NSDictionary*)proxyForJSON
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            _paymentTypes,@"payment_types",
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
