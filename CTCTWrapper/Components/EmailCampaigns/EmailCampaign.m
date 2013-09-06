//
//  EmailCampaigns.m
//  ConstantContact
//
//  Copyright (c) 2013 Costant Contact. All rights reserved.
//

#import "EmailCampaign.h"

@implementation EmailCampaign

- (id)init
{
    if (self = [super init])
    {
        _campaignId = @"";
        _name = @"";
        _subject = @"";
        _status = @"";
        _fromName = @"";
        _fromEmail = @"";
        _replyToEmail = @"";
        _campaignType = @"";
        _createdDate = @"";
        _modifiedDate = @"";
        _lastSendDate = @"";
        _lastRunDate = @"";
        _nextRunDate = @"";
        _isPermissionReminderEnabled = NO;
        _permissionReminderText = @"";
        _isViewAsWebpageEnabled = NO;
        _viewAsWebPageText = @"";
        _viewAsWebPageLinkText = @"";
        _greetingSalutations = @"";
        _greetingName = @"";
        _greetingString = @"";
        
        _messageFooter = [[MessageFooter alloc]init];
        _trackingSummary = [[TrackingSummary alloc]init];
        
        _emailContent = @"";
        _emailContentFormat = @"";
        _styleSheet = @"";
        _textContent = @"";
        _sentToContactLists = [[NSMutableArray alloc] init];
        _clickThroughDetails = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _campaignId = [Component valueForDictionary:dictionary withKey:@"id"];
        _name = [Component valueForDictionary:dictionary withKey:@"name"];
        _subject = [Component valueForDictionary:dictionary withKey:@"subject"];
        _status = [Component valueForDictionary:dictionary withKey:@"status"];
        _fromName = [Component valueForDictionary:dictionary withKey:@"from_name"];
        _fromEmail = [Component valueForDictionary:dictionary withKey:@"from_email"];
        _replyToEmail = [Component valueForDictionary:dictionary withKey:@"reply_to_email"];
        _campaignType = [Component valueForDictionary:dictionary withKey:@"campaign_type"];
        _createdDate = [Component valueForDictionary:dictionary withKey:@"created_date"];
        _modifiedDate = [Component valueForDictionary:dictionary withKey:@"modified_date"];
        _lastSendDate = [Component valueForDictionary:dictionary withKey:@"last_send_date"];
        _lastRunDate = [Component valueForDictionary:dictionary withKey:@"last_run_date"];
        _nextRunDate = [Component valueForDictionary:dictionary withKey:@"next_run_date"];
        
        BOOL value = [[Component valueForDictionary:dictionary withKey:@"is_permission_reminder_enabled"]boolValue];
        
        _isPermissionReminderEnabled = value;
        
        _permissionReminderText = [Component valueForDictionary:dictionary withKey:@"permission_reminder_text"];
        _isViewAsWebpageEnabled = [[Component valueForDictionary:dictionary withKey:@"is_view_as_webpage_enabled"]boolValue];
        _viewAsWebPageText = [Component valueForDictionary:dictionary withKey:@"view_as_web_page_text"];
        _viewAsWebPageLinkText = [Component valueForDictionary:dictionary withKey:@"view_as_web_page_link_text"];
        _greetingSalutations = [Component valueForDictionary:dictionary withKey:@"greeting_salutations"];
        _greetingName = [Component valueForDictionary:dictionary withKey:@"greeting_name"];
        _greetingString = [Component valueForDictionary:dictionary withKey:@"greeting_string"];
        
        if([dictionary objectForKey:@"message_footer"])
            _messageFooter = [MessageFooter messageFooterWithDictionary:[dictionary objectForKey:@"message_footer"]];
            
        if([dictionary objectForKey:@"tracking_summary"])
            _trackingSummary = [TrackingSummary trackingSummaryWithDictionary:[dictionary objectForKey:@"tracking_summary"]];
            
        _emailContent = [Component valueForDictionary:dictionary withKey:@"email_content"];
        _emailContentFormat = [Component valueForDictionary:dictionary withKey:@"email_content_format"];
        _styleSheet = [Component valueForDictionary:dictionary withKey:@"style_sheet"];
        _textContent = [Component valueForDictionary:dictionary withKey:@"text_content"];
        
        _sentToContactLists = [[NSMutableArray alloc] init];
        
        if([dictionary objectForKey:@"sent_to_contact_lists"])
           for(NSDictionary *sendToList in [dictionary objectForKey:@"sent_to_contact_lists"])
            {
                [_sentToContactLists addObject:[ContactList contactListWithDictionary:sendToList]];
            }

        _clickThroughDetails = [[NSMutableArray alloc] init];
        
        if([dictionary objectForKey:@"click_through_details"])
           for(NSDictionary *clickDetails in [dictionary objectForKey:@"click_through_details"])
            {
                [_clickThroughDetails addObject:[ClickThroughDetails clickThroughDetailsWithDictionary:[dictionary objectForKey:@"click_through_details"]]];
            }
    }
    return self;
}

+ (EmailCampaign *)emailCampaignWithDictionary:(NSDictionary *)dictionary;
{
    EmailCampaign *emailCampaign = [[EmailCampaign alloc] initWithDictionary:dictionary];
    
    return emailCampaign;
}



+ (EmailCampaign *)createSummaryWithDictionary:(NSDictionary *)dictionary
{
    EmailCampaign *emailCampaign = [[EmailCampaign alloc] initWithDictionary:dictionary];
    
//    emailCampaign.id = [Component valueForDictionary:dictionary withKey:@"id"];
//    emailCampaign.name = [Component valueForDictionary:dictionary withKey:@"name"];
//    emailCampaign.status = [Component valueForDictionary:dictionary withKey:@"status"];
//    emailCampaign.modifiedDate = [Component valueForDictionary:dictionary withKey:@"modified_date"];
    
    //    // remove unused fields
    //    foreach ($campaign as $key => $value) {
    //        if ($value == null) {
    //            unset($campaign->$key);
    //        }
    //    }
    
    return emailCampaign;
}

- (void)addContactList:(id)contactList
{
    ContactList *list = nil;
    
    if([contactList isKindOfClass:[ContactList class]])
    {
        list = contactList;
    }
    else if(contactList)
    {
        //----check if it is not and id if it is 
        list = [ContactList contactListWithDictionary:contactList];
    }
    else
    {
        NSLog(@"Error createing Contact list, invalid argument sent %@ ",contactList);
    }
    
    [self.sentToContactLists addObject:list];
}

- (NSDictionary*)proxyForJSON
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 _name, @"name",
                                 _subject, @"subject",
                                 _status, @"status",
                                 _fromName, @"from_name",
                                 _fromEmail, @"from_email",
                                 _replyToEmail, @"reply_to_email",
                                 [NSNumber numberWithBool:_isPermissionReminderEnabled], @"is_permission_reminder_enabled",
                                 _permissionReminderText, @"permission_reminder_text",
                                 [NSNumber numberWithBool:_isViewAsWebpageEnabled], @"is_view_as_webpage_enabled",
                                 _viewAsWebPageText, @"view_as_web_page_text",
                                 _viewAsWebPageLinkText, @"view_as_web_page_link_text",
                                 _greetingSalutations, @"greeting_salutations",
                                 _greetingName, @"greeting_name",
                                 _greetingString, @"greeting_string",
                                 _emailContent, @"email_content",
                                 _emailContentFormat, @"email_content_format",
                                 _styleSheet, @"style_sheet",
                                 _textContent, @"text_content",
                                 nil];

    if(_sentToContactLists.count > 0)
       {
           NSMutableArray *jsonArray = [[NSMutableArray alloc]init];
           for(ContactList *contactList in _sentToContactLists)
           {
               NSString *eachElementJson = [contactList JSONForMinimal];
               NSError *e = nil;
               NSDictionary *JSON =
               [NSJSONSerialization JSONObjectWithData: [eachElementJson dataUsingEncoding:NSUTF8StringEncoding]
                                               options: NSJSONReadingMutableContainers
                                                 error: &e];
               
               [jsonArray addObject:JSON];
           }
           [dict setValue:jsonArray forKey:@"sent_to_contact_lists"];
       }
           
    
       if(_messageFooter != (MessageFooter *)[NSNull null])
       {
           NSString *stringForJson = [_messageFooter JSON];
           NSError *e = nil;
           NSDictionary *JSON =
           [NSJSONSerialization JSONObjectWithData: [stringForJson dataUsingEncoding:NSUTF8StringEncoding]
                                           options: NSJSONReadingMutableContainers
                                             error: &e];
           
          [dict setObject:JSON forKey:@"message_footer"];
       }
    
    return dict;
}

-(NSDictionary*)proxyForMinimal
{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 _name, @"name",
                                 _subject, @"subject",
                                 _status,@"status",
                                 _fromName,@"from_name",
                                 _fromEmail,@"from_email",
                                 _replyToEmail,@"reply_to_email",
                                 [NSNumber numberWithBool:_isPermissionReminderEnabled],@"is_permission_reminder_enabled",
                                 _permissionReminderText,@"permission_reminder_text",
                                 [NSNumber numberWithBool:_isViewAsWebpageEnabled],@"is_view_as_webpage_enabled",
                                 _viewAsWebPageText,@"view_as_web_page_text",
                                 _viewAsWebPageLinkText,@"view_as_web_page_link_text",
                                 _greetingSalutations,@"greeting_salutations",
                                 _greetingName,@"greeting_name",
                                 _greetingString,@"greeting_string",
                                 _emailContent,@"email_content",
                                 _emailContentFormat,@"email_content_format",
                                 _styleSheet,@"style_sheet",
                                 _textContent,@"text_content",
                                 nil];
    
    if(_sentToContactLists.count > 0)
    {
        NSMutableArray *jsonArray = [[NSMutableArray alloc]init];
        for(ContactList *contactList in _sentToContactLists)
        {
            NSString *eachElementJson = [contactList JSONForMinimal];
            NSError *e = nil;
            NSDictionary *JSON =
            [NSJSONSerialization JSONObjectWithData: [eachElementJson dataUsingEncoding:NSUTF8StringEncoding]
                                            options: NSJSONReadingMutableContainers
                                              error: &e];
            
            [jsonArray addObject:JSON];
        }
        [dict setValue:jsonArray forKey:@"sent_to_contact_lists"];
    }
    
    
    if(_messageFooter != (MessageFooter *)[NSNull null])
    {
        NSString *stringForJson = [_messageFooter JSON];
        NSError *e = nil;
        NSDictionary *JSON =
        [NSJSONSerialization JSONObjectWithData: [stringForJson dataUsingEncoding:NSUTF8StringEncoding]
                                        options: NSJSONReadingMutableContainers
                                          error: &e];
        
        [dict setObject:JSON forKey:@"message_footer"];
    }
    
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

- (NSString *)minimalJSON
{
    NSDictionary *jsonDict = [self proxyForMinimal];
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
