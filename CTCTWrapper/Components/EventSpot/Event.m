//
//  Event.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "Event.h"

@implementation Event

- (id)init
{
    if (self = [super init])
    {
        _eventStatusEnum = [[EventStatusEnum alloc]init];
        _eventTypeEnum = [[EventTypeEnum alloc] init];
        
        _createdDate = @"";
        _timeZoneId = @"";
        _location = @"";
        _status = @"";
        _eventDetailUrl = @"";
        _totalRegisteredCount = 0;
        _registrationUrl = @"";
        _activeDate = @"";
        _type = @"";
        _eventId = @"";
        _isCheckinAvailable = FALSE;
        _deleteDate = @"";
        _title = @"";
        _endDate = @"";
        _addresses = [[EventAddress alloc] init];
        _desc = @"";
        _name = @"";
        _startDate = @"";
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _eventStatusEnum = [[EventStatusEnum alloc]init];
        _eventTypeEnum = [[EventTypeEnum alloc] init];
        
        _createdDate = [Component valueForDictionary:dictionary withKey:@"created_date"];
        _timeZoneId = [Component valueForDictionary:dictionary withKey:@"time_zone_id"];
        _location = [Component valueForDictionary:dictionary withKey:@"location"];
        _status = [Component valueForDictionary:dictionary withKey:@"status"];
        _eventDetailUrl = [Component valueForDictionary:dictionary withKey:@"event_detail_url"];
        _totalRegisteredCount = [[Component valueForDictionary:dictionary withKey:@"total_registered_count"] intValue];
        _registrationUrl = [Component valueForDictionary:dictionary withKey:@"registration_url"];
        _activeDate = [Component valueForDictionary:dictionary withKey:@"active_date"];
        _type = [Component valueForDictionary:dictionary withKey:@"type"];
        _eventId = [Component valueForDictionary:dictionary withKey:@"id"];
        _isCheckinAvailable = [[Component valueForDictionary:dictionary withKey:@"is_checkin_available"] boolValue];
        _deleteDate = [Component valueForDictionary:dictionary withKey:@"deleted_date"];
        _title = [Component valueForDictionary:dictionary withKey:@"title"];
        _endDate = [Component valueForDictionary:dictionary withKey:@"end_date"];
       
        _desc = [Component valueForDictionary:dictionary withKey:@"description"];
        _name = [Component valueForDictionary:dictionary withKey:@"name"];
        _startDate = [Component valueForDictionary:dictionary withKey:@"start_date"];
        
        if([dictionary objectForKey:@"address"])
            _addresses = [EventAddress eventAddressWithDictionary:[dictionary objectForKey:@"address"]];
    }
    
    return self;
}

+ (Event *)eventWithDictionary:(NSDictionary *)dictionary
{
    Event *event = [[Event alloc] initWithDictionary:dictionary];
    
    return event;
}

-(NSDictionary*)proxyForJSON
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    if(_createdDate) [dict setObject:_createdDate forKey:@"created_date"];
    if(_timeZoneId) [dict setObject:_timeZoneId forKey:@"time_zone_id"];
    if(_location) [dict setObject:_location forKey:@"location"];
    if(_status) [dict setObject:_status forKey:@"status"];
    if(_eventDetailUrl) [dict setObject:_eventDetailUrl forKey:@"event_detail_url"];
    if(_totalRegisteredCount) [dict setObject:[NSNumber numberWithInt:_totalRegisteredCount] forKey:@"total_registered_count"];
    if(_registrationUrl) [dict setObject:_registrationUrl forKey:@"registration_url"];
    if(_activeDate) [dict setObject:_activeDate forKey:@"active_date"];
    if(_type) [dict setObject:_type forKey:@"type"];
    if(_addresses) [dict setObject:[_addresses JSON] forKey:@"id"];
    if(_eventId) [dict setObject:_eventId forKey:@"created_date"];
    if([NSNumber numberWithBool:_isCheckinAvailable] != nil) [dict setObject: [NSNumber numberWithBool:_isCheckinAvailable] forKey:@"is_checkin_available"];
    if(_deleteDate) [dict setObject:_deleteDate forKey:@"deleted_date"];
    if(_title) [dict setObject:_title forKey:@"title"];
    if(_endDate) [dict setObject:_endDate forKey:@"end_date"];
    if(_desc) [dict setObject:_desc forKey:@"description"];
    if(_name) [dict setObject:_name forKey:@"name"];
    if(_startDate) [dict setObject:_startDate forKey:@"start_date"];

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
