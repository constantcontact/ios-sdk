//
//  EventNotificationOptions.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "EventNotificationOptions.h"

@implementation EventNotificationOptions

- (id)init
{
    if (self = [super init])
    {
        _isOptedIn = false;
        _notificationType = @"";
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _isOptedIn = [[Component valueForDictionary:dictionary withKey:@"is_opted_in"] boolValue];
        _notificationType = [Component valueForDictionary:dictionary withKey:@"notification_type"];
    }
    
    return self;
}

+ (EventNotificationOptions *)eventNotificationWithDictionary:(NSDictionary *)dictionary
{
    EventNotificationOptions *eventOp = [[EventNotificationOptions alloc] initWithDictionary:dictionary];
    
    return eventOp;
}

-(NSDictionary*)proxyForJSON
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    if([NSNumber numberWithBool:_isOptedIn] != nil)[dict setObject:[NSNumber numberWithBool:_isOptedIn] forKey:@"is_opted_in"];
    if(_notificationType)[dict setObject:_notificationType forKey:@"notification_type"];
    
    return dict;
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
