//
//  EventRegistrant.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "EventRegistrant.h"

@implementation EventRegistrant

- (id)init
{
    if (self = [super init])
    {
      _eventRegistrantAttendanceStatusEnum = [[EventRegistrantAttendanceStatusEnum alloc]init];
        
       _registrantId = @"";
       _ticketId = @"";
       _guestCount = 0;
       _firstName = @"";
       _updatedDate = @"";
       _registrationStatus = @"";
       _email = @"";
       _registrationDate = @"";
       _lastName = @"";
       _attendanceStatus = @"";
       _paymentStatus = @"";
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _eventRegistrantAttendanceStatusEnum = [[EventRegistrantAttendanceStatusEnum alloc]init];
        
        _registrantId = [Component valueForDictionary:dictionary withKey:@"id"];
        _ticketId = [Component valueForDictionary:dictionary withKey:@"ticket_id"];
        _guestCount = [[Component valueForDictionary:dictionary withKey:@"guest_count"] integerValue];
        _firstName = [Component valueForDictionary:dictionary withKey:@"first_name"];
        _updatedDate = [Component valueForDictionary:dictionary withKey:@"updated_date"];
        _registrationStatus = [Component valueForDictionary:dictionary withKey:@"registration_status"];
        _email = [Component valueForDictionary:dictionary withKey:@"email"];
        _registrationDate = [Component valueForDictionary:dictionary withKey:@"registration_date"];
        _lastName = [Component valueForDictionary:dictionary withKey:@"last_name"];
        _attendanceStatus = [Component valueForDictionary:dictionary withKey:@"attendance_status"];
        _paymentStatus = [Component valueForDictionary:dictionary withKey:@"payment_status"];
    }
    
    return self;
}

+ (EventRegistrant *)eventRegistrantWithDictionary:(NSDictionary *)dictionary
{
    EventRegistrant *eventRegistrant = [[EventRegistrant alloc] initWithDictionary:dictionary];
    
    return eventRegistrant;
}

-(NSDictionary*)proxyForJSON
{
     NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    if(_registrantId)[dict setObject:_registrantId forKey:@"id"];
    if(_ticketId)[dict setObject:_ticketId forKey:@"ticket_id"];
    if(_guestCount)[dict setObject:[NSNumber numberWithInt:_guestCount] forKey:@"guest_count"];
    if(_firstName)[dict setObject:_firstName forKey:@"first_name"];
    if(_updatedDate)[dict setObject:_updatedDate forKey:@"updated_date"];
    if(_registrationStatus)[dict setObject:_registrationStatus forKey:@"registration_status"];
    if(_email)[dict setObject:_email forKey:@"email"];
    if(_registrationDate)[dict setObject:_registrationDate forKey:@"registration_date"];
    if(_lastName)[dict setObject:_lastName forKey:@"last_name"];
    if(_attendanceStatus)[dict setObject:_attendanceStatus forKey:@"attendance_status"];
    if(_paymentStatus)[dict setObject:_paymentStatus forKey:@"payment_status"];
    
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
