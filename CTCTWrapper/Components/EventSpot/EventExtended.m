//
//  EventExtended.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "EventExtended.h"

@implementation EventExtended

- (id)init
{
    if (self = [super init])
    {
       _eventCurrencyTypeEnum = [[EventCurrencyTypeEnum alloc] init];
       _eventStatusEnum = [[EventStatusEnum alloc] init];
       _eventTypeEnum = [[EventTypeEnum alloc] init];
       _eventPaymentTypeEnum = [[EventPaymentTypeEnum alloc] init];
        
        _activeDate = @"";
        _address = [[EventAddress alloc]init];
        _areRegistrantsPublic = false;
        _cancelledDate = @"";
        _contact = [[EventContact alloc]init];
        _createdDate = @"";
        _currencyType = @"";
        _deleteDate = @"";
        _desc = @"";
        _endDate = @"";
        _googleAnalyticsKey = @"";
        _googleMerchantId = @"";
        _eventId = @"";
        _isCalendarDisplayed = false;
        _isCheckinAvailable = false;
        _isHomePageDisplayed = false;
        _isListedInExternalDirectory= false;
        _isMapDisplayed = false;
        _isVirtualEvent = false;
        _location = @"";
        _metaDataTags = @"";
        _name = @"";
        _notificationOptions = [[NSMutableArray alloc]init];
        _onlineMeeting = [[EventOnlineMeeting alloc]init];
        _payableTo = @"";
        _paymentAddress = [[EventAddress alloc]init];
        _paymentOptions = [[NSMutableArray alloc]init];
        _paypalAccountEmail = @"";
        _registrationUrl = @"";
        _startDate = @"";
        _status = @"";
        _themeName = @"";
        _timeZoneDescription = @"";
        _timeZoneId = @"";
        _title = @"";
        _totalRegisteredCount = @"";
        _trackInformation = [[EventTrackInformation alloc]init];
        _twitterHashTag = @"";
        _type = @"";
        _updateDate = @"";
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _eventCurrencyTypeEnum = [[EventCurrencyTypeEnum alloc] init];
        _eventStatusEnum = [[EventStatusEnum alloc] init];
        _eventTypeEnum = [[EventTypeEnum alloc] init];
        _eventPaymentTypeEnum = [[EventPaymentTypeEnum alloc] init];
        
        _activeDate = [Component valueForDictionary:dictionary withKey:@"active_date"];
        _areRegistrantsPublic = [[Component valueForDictionary:dictionary withKey:@"are_registrants_public"] boolValue];
        _cancelledDate = [Component valueForDictionary:dictionary withKey:@"cancelled_date"];
        _createdDate = [Component valueForDictionary:dictionary withKey:@"created_date"];
        _currencyType = [Component valueForDictionary:dictionary withKey:@"currency_type"];
        _deleteDate = [Component valueForDictionary:dictionary withKey:@"deleted_date"];
        _desc = [Component valueForDictionary:dictionary withKey:@"description"];
        _endDate = [Component valueForDictionary:dictionary withKey:@"end_date"];
        _googleAnalyticsKey = [Component valueForDictionary:dictionary withKey:@"google_analytics_key"];
        _googleMerchantId = [Component valueForDictionary:dictionary withKey:@"google_merchant_id"];
        _eventId = [Component valueForDictionary:dictionary withKey:@"id"];
        _isCalendarDisplayed = [[Component valueForDictionary:dictionary withKey:@"is_calendar_displayed"] boolValue];
        _isCheckinAvailable = [[Component valueForDictionary:dictionary withKey:@"is_checkin_available"] boolValue];
        _isHomePageDisplayed = [[Component valueForDictionary:dictionary withKey:@"is_home_page_displayed"] boolValue];
        _isListedInExternalDirectory = [[Component valueForDictionary:dictionary withKey:@"is_listed_in_external_directory"] boolValue];
        _isMapDisplayed = [[Component valueForDictionary:dictionary withKey:@"is_map_displayed"] boolValue];
        _isVirtualEvent = [[Component valueForDictionary:dictionary withKey:@"is_virtual_event"] boolValue];
        _location = [Component valueForDictionary:dictionary withKey:@"location"];
        _metaDataTags = [Component valueForDictionary:dictionary withKey:@"meta_data_tags"];
        _name = [Component valueForDictionary:dictionary withKey:@"name"];
        _payableTo = [Component valueForDictionary:dictionary withKey:@"payable_to"];
        _paypalAccountEmail = [Component valueForDictionary:dictionary withKey:@"paypal_account_email"];
        _registrationUrl = [Component valueForDictionary:dictionary withKey:@"registration_url"];
        _startDate = [Component valueForDictionary:dictionary withKey:@"start_date"];
        _status = [Component valueForDictionary:dictionary withKey:@"status"];
        _themeName = [Component valueForDictionary:dictionary withKey:@"theme_name"];
        _timeZoneDescription = [Component valueForDictionary:dictionary withKey:@"time_zone_description"];
        _timeZoneId = [Component valueForDictionary:dictionary withKey:@"time_zone_id"];
        _title = [Component valueForDictionary:dictionary withKey:@"title"];
        _totalRegisteredCount = [Component valueForDictionary:dictionary withKey:@"total_registered_count"];
         _twitterHashTag = [Component valueForDictionary:dictionary withKey:@"twitter_hash_tag"];
        _type = [Component valueForDictionary:dictionary withKey:@"type"];
        _updateDate = [Component valueForDictionary:dictionary withKey:@"updated_date"];
        
        if([dictionary objectForKey:@"address"])
                _address = [EventAddress eventAddressWithDictionary:[dictionary objectForKey:@"address"]];
        
        if([dictionary objectForKey:@"contact"])
               _contact = [EventContact eventContactWithDictionary:[dictionary objectForKey:@"contact"]];
        
        
        _notificationOptions = [[NSMutableArray alloc]init];
        if([dictionary objectForKey:@"notification_options"])
            for(NSDictionary *notif in [dictionary objectForKey:@"notification_options"])
            {
                [_notificationOptions addObject:[EventNotificationOptions eventNotificationWithDictionary:notif]];
            }
        
        if([dictionary objectForKey:@"online_meeting"])
                _onlineMeeting = [EventOnlineMeeting eventOnlineMeetingWithDictionary:[dictionary objectForKey:@"online_meeting"]];
            
        
        if([dictionary objectForKey:@"payment_address"])
                _paymentAddress = [EventAddress eventAddressWithDictionary:[dictionary objectForKey:@"payment_address"]];
        
        _paymentOptions = [[NSMutableArray alloc]init];
        if([dictionary objectForKey:@"payment_options"])
            for(NSString *paymentOpt in [dictionary objectForKey:@"payment_options"])
            {
                [_paymentOptions addObject:paymentOpt];
            }
        
        if([dictionary objectForKey:@"track_information"])
           _trackInformation = [EventTrackInformation eventTrackInfoWithDictionary:[dictionary objectForKey:@"track_information"]];
    }
    
    return self;
}

+ (EventExtended *)eventExtendedWithDictionary:(NSDictionary *)dictionary;
{
    EventExtended *event = [[EventExtended alloc] initWithDictionary:dictionary];
    
    return event;
}

-(NSDictionary*)proxyForJSON
{
    NSError *e;
    NSDictionary *JSON = nil;
    NSString *eachElementJson;
    
    if(_contact)
    {
    eachElementJson = [_contact JSON];
    e = nil;
    JSON =
    [NSJSONSerialization JSONObjectWithData: [eachElementJson dataUsingEncoding:NSUTF8StringEncoding]
                                    options: NSJSONReadingMutableContainers
                                      error: &e];
    }
    NSDictionary *jsonContact = JSON;
    JSON = nil;
    
    if(_address)
    {
    eachElementJson = [_address JSON];
    e = nil;
    JSON =
    [NSJSONSerialization JSONObjectWithData: [eachElementJson dataUsingEncoding:NSUTF8StringEncoding]
                                    options: NSJSONReadingMutableContainers
                                      error: &e];
    
    }
    NSDictionary *jsonAddress = JSON;
    JSON = nil;
    
    if(_paymentAddress)
    {
    eachElementJson = [_paymentAddress JSON];
    e = nil;
    JSON =
    [NSJSONSerialization JSONObjectWithData: [eachElementJson dataUsingEncoding:NSUTF8StringEncoding]
                                    options: NSJSONReadingMutableContainers
                                      error: &e];
    }
    NSDictionary *jsonPaymentAddress = JSON;
    JSON = nil;
    
    if(_trackInformation)
    {
    eachElementJson = [_trackInformation JSON];
    e = nil;
    JSON =
    [NSJSONSerialization JSONObjectWithData: [eachElementJson dataUsingEncoding:NSUTF8StringEncoding]
                                    options: NSJSONReadingMutableContainers
                                      error: &e];
    }
    NSDictionary *jsonTrackInfo = JSON;
    JSON = nil;
    
    if(_onlineMeeting)
    {
    eachElementJson = [_onlineMeeting JSON];
    e = nil;
    JSON =
    [NSJSONSerialization JSONObjectWithData: [eachElementJson dataUsingEncoding:NSUTF8StringEncoding]
                                    options: NSJSONReadingMutableContainers
                                      error: &e];
    }
    NSDictionary *jsonOnlineMeeting = JSON;
    JSON = nil;
    
    
    NSMutableArray *jsonNotifArray = [[NSMutableArray alloc]init];
    if(_notificationOptions.count > 0)
    {
        for(EventNotificationOptions *notif in _notificationOptions)
        {
            NSString *eachElementJson = [notif JSON];
            NSError *e = nil;
            NSDictionary *JSON =
            [NSJSONSerialization JSONObjectWithData: [eachElementJson dataUsingEncoding:NSUTF8StringEncoding]
                                            options: NSJSONReadingMutableContainers
                                              error: &e];
            
            [jsonNotifArray addObject:JSON];
        }
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    if([NSNumber numberWithBool:_areRegistrantsPublic] != nil) [dict setObject:[NSNumber numberWithBool:_areRegistrantsPublic] forKey:@"are_registrants_public"];
    if(jsonContact) [dict setObject:jsonContact forKey:@"contact"];
    if(_currencyType) [dict setObject:_currencyType forKey:@"currency_type"];
    if(_desc) [dict setObject:_desc forKey:@"description"];
    if(_endDate) [dict setObject:_endDate forKey:@"end_date"];
    if(_googleAnalyticsKey) [dict setObject:_googleAnalyticsKey forKey:@"google_analytics_key"];
    if(_googleMerchantId) [dict setObject:_googleMerchantId forKey:@"google_merchant_id"];
    if([NSNumber numberWithBool:_isCalendarDisplayed] != nil) [dict setObject:[NSNumber numberWithBool:_isCalendarDisplayed] forKey:@"is_calendar_displayed"];
    if([NSNumber numberWithBool:_isCheckinAvailable] != nil) [dict setObject:[NSNumber numberWithBool:_isCheckinAvailable]forKey:@"is_checkin_available"];
    if([NSNumber numberWithBool:_isHomePageDisplayed] != nil) [dict setObject:[NSNumber numberWithBool:_isHomePageDisplayed] forKey:@"is_home_page_displayed"];
    if([NSNumber numberWithBool:_isListedInExternalDirectory] != nil) [dict setObject:[NSNumber numberWithBool:_isListedInExternalDirectory] forKey:@"is_listed_in_external_directory"];
    if([NSNumber numberWithBool:_isMapDisplayed] != nil) [dict setObject:[NSNumber numberWithBool:_isMapDisplayed] forKey:@"is_map_displayed"];
    if([NSNumber numberWithBool:_isVirtualEvent] != nil) [dict setObject:[NSNumber numberWithBool:_isVirtualEvent] forKey:@"is_virtual_event"];
    if(_location) [dict setObject:_location forKey:@"location"];
    if(_metaDataTags) [dict setObject:_metaDataTags forKey:@"meta_data_tags"];
    if(_name) [dict setObject:_name forKey:@"name"];
    if(jsonNotifArray.count > 0) [dict setObject:jsonNotifArray forKey:@"notification_options"];
    if(jsonOnlineMeeting) [dict setObject:jsonOnlineMeeting forKey:@"online_meeting"];
    if(_payableTo) [dict setObject:_payableTo forKey:@"payable_to"];
    if(jsonPaymentAddress) [dict setObject:jsonPaymentAddress forKey:@"payment_address"];
    if(_paymentOptions) [dict setObject:_paymentOptions forKey:@"payment_options"];
    if(_paypalAccountEmail) [dict setObject:_paypalAccountEmail forKey:@"paypal_account_email"];
    if(_startDate) [dict setObject:_startDate forKey:@"start_date"];
    if(_themeName) [dict setObject:_themeName forKey:@"theme_name"];
    if(_timeZoneId) [dict setObject:_timeZoneId forKey:@"time_zone_id"];
    if(_title) [dict setObject:_title forKey:@"title"];
    if(jsonTrackInfo) [dict setObject:jsonTrackInfo forKey:@"track_information"];
    if(_twitterHashTag) [dict setObject:_twitterHashTag forKey:@"twitter_hash_tag"];
    if(_type) [dict setObject:_type forKey:@"type"];
    
    if(!_isVirtualEvent)
        [dict setObject:jsonAddress forKey:@"address"];
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
