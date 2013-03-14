//
//  Schedule.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "Schedule.h"

@implementation Schedule

- (id)init
{
    if (self = [super init])
    {
        _scheduleId = @"";
        _scheduledDate = @"";
    }
    
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _scheduleId = [Component valueForDictionary:dictionary withKey:@"id"];
        _scheduledDate = [Component valueForDictionary:dictionary withKey:@"scheduled_date"];
    }
    
    return self;
}

+ (Schedule *)scheduleWithDictionary:(NSDictionary *)dictionary
{
    Schedule *schedule = [[Schedule alloc] init];
    
    schedule.scheduleId = [Component valueForDictionary:dictionary withKey:@"id"];
    schedule.scheduledDate = [Component valueForDictionary:dictionary withKey:@"scheduled_date"];
    
    return schedule;
}

-(id) proxyForJson
{
    return [NSDictionary dictionaryWithObjectsAndKeys: _scheduledDate, @"scheduled_date",_scheduleId,@"id",nil];
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
