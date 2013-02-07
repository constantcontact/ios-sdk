//
//  Contact.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "Contact.h"
#import <Foundation/Foundation.h>

@implementation Contact

- (id)init
{
    if (self = [super init])
    {
        _id = 0;
        _status = @"";
        _firstName = @"";
        _middleName = @"";
        _lastName = @"";
        _emailAddresses = [[NSMutableArray alloc] init];
        _prefixName = @"";
        _jobTitle = @"";
        _departmentName = @"";
        _addresses = [[NSMutableArray alloc] init];
        _companyName = @"";
        _homePhone = @"";
        _workPhone = @"";
        _cellPhone = @"";
        _fax = @"";
        _customFields = [[NSMutableArray alloc] init];
        _lastUpdateTime = @"";
        _lists = [[NSMutableArray alloc] init];
        _sourceDetails = @"";
        _sourceIsUrl = NO;
        _actionBy = @"";
        _webUrl = @"";
    }
    
    return self;
}


-(id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _id = [[Component valueForDictionary:dictionary withKey:@"id"]integerValue];
        _status = [Component valueForDictionary:dictionary withKey:@"status"];
        _firstName = [Component valueForDictionary:dictionary withKey:@"first_name"];
        _middleName = [Component valueForDictionary:dictionary withKey:@"middle_name"];
        _lastName = [Component valueForDictionary:dictionary withKey:@"last_name"];
        _sourceDetails = [Component valueForDictionary:dictionary withKey:@"source_details"];
        _sourceIsUrl = [[Component valueForDictionary:dictionary withKey:@"source_is_url"]intValue];
        _actionBy = [Component valueForDictionary:dictionary withKey:@"action_by"];
        _webUrl = [Component valueForDictionary:dictionary withKey:@"web_url"];
        _lastUpdateTime = [Component valueForDictionary:dictionary withKey:@"last_update_time"];
        _companyName = [Component valueForDictionary:dictionary withKey:@"company_name"];
        _homePhone = [Component valueForDictionary:dictionary withKey:@"home_phone"];
        _workPhone = [Component valueForDictionary:dictionary withKey:@"work_phone"];
        _cellPhone = [Component valueForDictionary:dictionary withKey:@"cell_phone"];
        _fax = [Component valueForDictionary:dictionary withKey:@"fax"];
        _prefixName = [Component valueForDictionary:dictionary withKey:@"prefix_name"];
        _jobTitle = [Component valueForDictionary:dictionary withKey:@"job_title"];
        _departmentName = [Component valueForDictionary:dictionary withKey:@"department_name"];
        
        _emailAddresses = [[NSMutableArray alloc] init];
        
              
        for(EmailAddress *emailAddress in [dictionary objectForKey:@"email_addresses"])
        {
            EmailAddress *value =emailAddress;// [[dictionary objectForKey:@"email_addresses"] objectForKey:emailAddress];
            [_emailAddresses addObject:value];
        }
        
        _addresses = [[NSMutableArray alloc] init];
        
        for (Address *address in [dictionary objectForKey:@"addresses"])
        {
            Address *value =address; // [[dictionary objectForKey:@"addresses"] objectForKey:address];
            [_addresses addObject:value];
        }
        
        _customFields = [[NSMutableArray alloc] init];
        
        for (CustomField *customField in [dictionary objectForKey:@"custom_fields"])
        {
            CustomField *value =customField; // [[dictionary objectForKey:@"custom_fields"] objectForKey:customField];
            [_customFields addObject:value];
        }
        _lists = [[NSMutableArray alloc] init];
        
        for (ContactList *contactList in [dictionary objectForKey:@"lists"])
        {
            ContactList *value = contactList;//[[dictionary objectForKey:@"lists"] objectForKey:contactList];
            [_lists addObject:value];
        }
    }
    return self;
}

+(Contact*)contactWithDictionary:(NSDictionary *)dictionary
{
    Contact *contact = [[Contact alloc] init];
    contact.id = [[Component valueForDictionary:dictionary withKey:@"id"]integerValue];
    contact.status = [Component valueForDictionary:dictionary withKey:@"status"];
    contact.firstName = [Component valueForDictionary:dictionary withKey:@"first_name"];
    contact.middleName = [Component valueForDictionary:dictionary withKey:@"middle_name"];
    contact.lastName = [Component valueForDictionary:dictionary withKey:@"last_name"];
    contact.sourceDetails = [Component valueForDictionary:dictionary withKey:@"source_details"];
    contact.sourceIsUrl = [[Component valueForDictionary:dictionary withKey:@"source_is_url"]intValue];
    contact.actionBy = [Component valueForDictionary:dictionary withKey:@"action_by"];
    contact.webUrl = [Component valueForDictionary:dictionary withKey:@"web_url"];
    contact.lastUpdateTime = [Component valueForDictionary:dictionary withKey:@"last_update_time"];
    contact.companyName = [Component valueForDictionary:dictionary withKey:@"company_name"];
    contact.homePhone = [Component valueForDictionary:dictionary withKey:@"home_phone"];
    contact.workPhone = [Component valueForDictionary:dictionary withKey:@"work_phone"];
    contact.cellPhone = [Component valueForDictionary:dictionary withKey:@"cell_phone"];
    contact.fax = [Component valueForDictionary:dictionary withKey:@"fax"];
    contact.prefixName = [Component valueForDictionary:dictionary withKey:@"prefix_name"];
    contact.jobTitle = [Component valueForDictionary:dictionary withKey:@"job_title"];
    contact.departmentName = [Component valueForDictionary:dictionary withKey:@"department_name"];
    
    contact.emailAddresses = [[NSMutableArray alloc] init];
    
    for(EmailAddress *emailAddress in [dictionary objectForKey:@"email_addresses"])
    {
        EmailAddress *value = emailAddress; //[[dictionary objectForKey:@"email_addresses"] objectForKey:emailAddress];
        [contact.emailAddresses addObject:value];
    }
    
    contact.addresses = [[NSMutableArray alloc] init];
    
    for (Address *address in [dictionary objectForKey:@"addresses"])
    {
        Address *value = address;//[[dictionary objectForKey:@"addresses"] objectForKey:address];
        [ contact.addresses addObject:value];
    }
    
    contact.customFields = [[NSMutableArray alloc] init];
    
    for (CustomField *customField in [dictionary objectForKey:@"custom_fields"])
    {
        CustomField *value = customField;//[[dictionary objectForKey:@"custom_fields"] objectForKey:customField];
        [contact.customFields addObject:value];
    }
    
    contact.lists = [[NSMutableArray alloc] init];
    
    for (ContactList *contactList in [dictionary objectForKey:@"lists"])
    {
        ContactList *value = contactList;//[[dictionary objectForKey:@"lists"] objectForKey:contactList];
        [contact.lists addObject:value];
    }
    return contact;
}

-(void) addList:(ContactList*)contactList
{
    if (!_lists)
        _lists = [[NSMutableArray alloc] init];
    
    [_lists addObject:contactList];
}

-(void) addEmailAddress:(EmailAddress*)emailAddress
{
    if (!_emailAddresses)
        _emailAddresses = [[NSMutableArray alloc] init];
    
    [_emailAddresses addObject:emailAddress];
}

-(void) addAddress:(Address*)address
{
    if (!_addresses)
        _addresses = [[NSMutableArray alloc] init];
    
    [_addresses addObject:address];
}

- (NSArray*)emailAddressesForJson
{
    NSMutableArray *emailAddresses = [[NSMutableArray alloc] initWithCapacity:self.emailAddresses.count];
    
    for (EmailAddress *email in self.emailAddresses)
    {
        [emailAddresses addObject:[email proxyForJson]];
    }
    
    return emailAddresses;
}

-(id) proxyForJson
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSDate* serverDate = [dateFormatter dateFromString:_lastUpdateTime];
    
    return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:_id ], @"id", _status, @"status", _firstName, @"first_name", _middleName, @"middle_name", _lastName, @"last_name", [self emailAddressesForJson], @"email_addresses", _prefixName, @"prefix_name", _jobTitle, @"job_title", _departmentName, @"department_name", _addresses, @"addresses", _companyName, @"company_name", _homePhone, @"home_phone", _workPhone, @"work_phone", _cellPhone, @"cell_phone", _fax, @"fax", _customFields, @"custom_fields", serverDate, @"last_update_time", _lists, @"lists", _sourceDetails, @"source_details",[NSNumber numberWithBool:_sourceIsUrl], @"source_is_url", _actionBy, @"action_by", _webUrl, @"web_url", nil];
}

-(NSString*) toJson
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
