//
//  EventOnlineMeeting.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "EventOnlineMeeting.h"

@implementation EventOnlineMeeting

- (id)init
{
    if (self = [super init])
    {
        _instructions = @"";
        _providerMeetingId = @"";
        _providerType = @"";
        _url = @"";
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _instructions = [Component valueForDictionary:dictionary withKey:@"instructions"];
        _providerMeetingId =  [Component valueForDictionary:dictionary withKey:@"provider_meeting_id"];
        _providerType =  [Component valueForDictionary:dictionary withKey:@"provider_type"];
        _url =  [Component valueForDictionary:dictionary withKey:@"url"];
    }
    
    return self;
}

+ (EventOnlineMeeting *)eventOnlineMeetingWithDictionary:(NSDictionary *)dictionary
{
    EventOnlineMeeting *eventMeetings = [[EventOnlineMeeting alloc] initWithDictionary:dictionary];
    
    return eventMeetings;
}

-(NSDictionary*)proxyForJSON
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    if(_instructions) [dict setObject:_instructions forKey:@"instructions"];
    if(_providerMeetingId) [dict setObject:_providerMeetingId forKey:@"provider_meeting_id"];
    if(_url) [dict setObject:_url forKey:@"url"];
    
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
