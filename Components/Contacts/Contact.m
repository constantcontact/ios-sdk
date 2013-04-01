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
        _contactId = @"";
        _status = @"";
        _firstName = @"";
        _middleName = @"";
        _lastName = @"";
        _emailAddresses = [[NSMutableArray alloc] init];
        _prefixName = @"";
        _jobTitle = @"";
        _addresses = [[NSMutableArray alloc] init];
        _companyName = @"";
        _homePhone = @"";
        _workPhone = @"";
        _cellPhone = @"";
        _fax = @"";
        _customFields = [[NSMutableArray alloc] init];
        _modifiedDate = @"";
        _lists = [[NSMutableArray alloc] init];
        _sourceDetails = @"";
    }
    return self;
}


- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _contactId = [Component valueForDictionary:dictionary withKey:@"id"];
        _status = [Component valueForDictionary:dictionary withKey:@"status"];
        _firstName = [Component valueForDictionary:dictionary withKey:@"first_name"];
        _middleName = [Component valueForDictionary:dictionary withKey:@"middle_name"];
        _lastName = [Component valueForDictionary:dictionary withKey:@"last_name"];
        _sourceDetails = [Component valueForDictionary:dictionary withKey:@"source_details"];
        _modifiedDate = [Component valueForDictionary:dictionary withKey:@"modified_date"];
        _companyName = [Component valueForDictionary:dictionary withKey:@"company_name"];
        _homePhone = [Component valueForDictionary:dictionary withKey:@"home_phone"];
        _workPhone = [Component valueForDictionary:dictionary withKey:@"work_phone"];
        _cellPhone = [Component valueForDictionary:dictionary withKey:@"cell_phone"];
        _fax = [Component valueForDictionary:dictionary withKey:@"fax"];
        _prefixName = [Component valueForDictionary:dictionary withKey:@"prefix_name"];
        _jobTitle = [Component valueForDictionary:dictionary withKey:@"job_title"];
        
        _emailAddresses = [[NSMutableArray alloc] init];
        
        for(NSDictionary *emailAddress in [dictionary objectForKey:@"email_addresses"])
        {
            EmailAddress *value = [EmailAddress emailAddressWithDictionary:emailAddress];
            [_emailAddresses addObject:value];
        }
        
        _addresses = [[NSMutableArray alloc] init];
        
        for (NSDictionary *address in [dictionary objectForKey:@"addresses"])
        {
            Address *value = [Address addressWithDictionary:address];
            [_addresses addObject:value];
        }
        
        _notes = [[NSMutableArray alloc] init];
        
        for (NSDictionary *note in [dictionary objectForKey:@"notes"])
        {
            Note *value = [Note NoteWithDictionary:note];
            [_notes addObject:value];
        }
        
        _customFields = [[NSMutableArray alloc] init];
        
        for (NSDictionary *customField in [dictionary objectForKey:@"custom_fields"])
        {
            CustomField *value = [CustomField customFieldWithDictionary:customField];
            [_customFields addObject:value];
        }
        
        _lists = [[NSMutableArray alloc] init];
        
        for (NSDictionary *contactList in [dictionary objectForKey:@"lists"])
        {
            ContactList *value = [ContactList contactListWithDictionary:contactList];
            [_lists addObject:value];
        }
    }
    return self;
}

+ (Contact*)contactWithDictionary:(NSDictionary *)dictionary
{
    Contact *contact = [[Contact alloc] initWithDictionary:dictionary];
    return contact;
}

- (void)addList:(ContactList*)contactList
{
    if (!_lists)
        _lists = [[NSMutableArray alloc] init];
    
    [_lists addObject:contactList];
}

- (void)addEmailAddress:(EmailAddress*)emailAddress
{
    if (!_emailAddresses)
        _emailAddresses = [[NSMutableArray alloc] init];
    
    [_emailAddresses addObject:emailAddress];
}

- (void)addAddress:(Address*)address
{
    if (!_addresses)
        _addresses = [[NSMutableArray alloc] init];
    
    [_addresses addObject:address];
}

- (NSArray*)emailAddressesForJSON
{
    NSMutableArray *emailAddresses = [[NSMutableArray alloc] initWithCapacity:_emailAddresses.count];
    
    for (EmailAddress *email in _emailAddresses)
    {
        [emailAddresses addObject:[email proxyForJSON]];
    }
    
    return emailAddresses;
}

- (NSArray*)addressesForJSON
{
    NSMutableArray *addresses = [[NSMutableArray alloc] initWithCapacity:_addresses.count];
    
    for (Address *address in _addresses)
    {
        [addresses addObject:[address proxyForJSON]];
    }
    return addresses;
}

- (NSArray*)notesForJSON
{
    NSMutableArray *notes = [[NSMutableArray alloc] initWithCapacity:_notes.count];
    
    for (Note *note in _notes)
    {
        [notes addObject:[note proxyForJSON]];
    }
    return notes;
}

- (NSArray*)listsForJSON
{
    NSMutableArray *lists = [[NSMutableArray alloc] initWithCapacity:_lists.count];
    
    for (ContactList *list in _lists)
    {
        [lists addObject:[list proxyForMinimal]];
    }
    
    return lists;
}

- (NSArray*)customFieldsForJSON
{
    NSMutableArray *customFields = [[NSMutableArray alloc] initWithCapacity:_customFields.count];
    
    for (CustomField *customField in _customFields)
    {
        [customFields addObject:[customField proxyForJSON]];
    }
    
    return customFields;
}

- (NSDictionary*)proxyForInsert
{
    NSDictionary *dictForJSON = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [self addressesForJSON], @"addresses",
                                 [self notesForJSON], @"notes",
                                 [self listsForJSON], @"lists",
                                 [self emailAddressesForJSON], @"email_addresses",
                                 _prefixName, @"prefix_name",
                                 _firstName, @"first_name",
                                 _middleName, @"middle_name",
                                 _lastName, @"last_name",
                                 _jobTitle, @"job_title",
                                 _companyName, @"company_name",
                                 _homePhone, @"home_phone",
                                 _workPhone, @"work_phone",
                                 _cellPhone, @"cell_phone",
                                 _fax, @"fax",
                                 [self customFieldsForJSON], @"custom_fields",
                                 nil];
    
    return dictForJSON;
}

- (NSString*)JSONForInsert
{
    NSDictionary *JSONDict = [self proxyForInsert];
    NSError *error;
    NSData *JSONData = [NSJSONSerialization dataWithJSONObject:JSONDict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *JSONString = @"";
    
    if (!JSONData) {
        NSLog(@"Got an error: %@", error);
    } else {
        JSONString = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
    }
    
    return JSONString;
}

- (NSDictionary*)proxyForUpdate
{
    NSDictionary *dictForJSON = [NSDictionary dictionaryWithObjectsAndKeys:
                                 _status, @"status",
                                 [self addressesForJSON], @"addresses",
                                 [self notesForJSON], @"notes",
                                 [self listsForJSON], @"lists",
                                 [self emailAddressesForJSON], @"email_addresses",
                                 _prefixName, @"prefix_name",
                                 _firstName, @"first_name",
                                 _middleName, @"middle_name",
                                 _lastName, @"last_name",
                                 _jobTitle, @"job_title",
                                 _companyName, @"company_name",
                                 _homePhone, @"home_phone",
                                 _workPhone, @"work_phone",
                                 _cellPhone, @"cell_phone",
                                 _fax, @"fax",
                                 [self customFieldsForJSON], @"custom_fields",
                                 nil];
    
    return dictForJSON;
}

- (NSString*)JSONForUpdate
{
    NSDictionary *JSONDict = [self proxyForUpdate];
    NSError *error;
    NSData *JSONData = [NSJSONSerialization dataWithJSONObject:JSONDict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *JSONString = @"";
    
    if (!JSONData) {
        NSLog(@"Got an error: %@", error);
    } else {
        JSONString = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
    }
    
    return JSONString;
}

@end
