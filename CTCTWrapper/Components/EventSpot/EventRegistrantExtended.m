//
//  EventRegistrantExtended.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "EventRegistrantExtended.h"

@implementation EventRegistrantExtended

- (id)init
{
    if (self = [super init])
    {
        _eventRegistrantAttendanceStatusEnum = [[EventRegistrantAttendanceStatusEnum alloc]init];
        
        _attendanceStatus = @"";
        _guests = [[RegistrantGuest alloc]init];
        _registrantId = @"";
        _ticketId = @"";
        _sections = [[NSMutableArray alloc]init];
        _registrantStatus = @"";
        _registrationDate = @"";
        _paymentSummary = [[RegistrantPaymentSummary alloc]init];
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
        _registrantStatus = [Component valueForDictionary:dictionary withKey:@"registration_status"];
        _registrationDate = [Component valueForDictionary:dictionary withKey:@"registration_date"];
        _attendanceStatus = [Component valueForDictionary:dictionary withKey:@"attendance_status"];
        
        _sections = [[NSMutableArray alloc]init];
        if([dictionary objectForKey:@"sections"])
            for(NSDictionary *section in [dictionary objectForKey:@"sections"])
            {
                [_sections addObject:[RegistrantSection registrantSectionWithDictionary:section]];
            }

        if([dictionary objectForKey:@"guests"])
                _guests =[RegistrantGuest registrantGuestWithDictionary:[dictionary objectForKey:@"guests"]];
        
                  
        if([dictionary objectForKey:@"payment_summary"])
            _paymentSummary = [RegistrantPaymentSummary registrantPaymentSummartWithDictionary:[dictionary objectForKey:@"payment_summary"]];

    }
    
    return self;
}

+ (EventRegistrantExtended *)eventRegistrantExtendedWithDictionary:(NSDictionary *)dictionary;
{
    EventRegistrantExtended *eventReg = [[EventRegistrantExtended alloc] initWithDictionary:dictionary];
    
    return eventReg;
}


@end
