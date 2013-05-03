//
//  AddContactsImportData.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "AddContactsImportData.h"

@implementation AddContactsImportData

- (id)init
{
    if (self = [super init])
    {
        _firstName = @"";
        _middleName = @"";
        _lastName = @"";
        _jobTitle = @"";
        _companyName = @"";
        _workPhone = @"";
        _homePhone = @"";
        
        _emailAddresses = [[NSMutableArray alloc]init];
        _addresses = [[NSMutableArray alloc]init];
        _customFields = [[NSMutableArray alloc]init];
    }
    
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    
    self = [super init];
    
    _firstName = [Component valueForDictionary:dictionary withKey:@"first_name"];
    _middleName = [Component valueForDictionary:dictionary withKey:@"middle_name"];
    _lastName = [Component valueForDictionary:dictionary withKey:@"last_name"];
    _jobTitle = [Component valueForDictionary:dictionary withKey:@"job_title"];
    _companyName = [Component valueForDictionary:dictionary withKey:@"company_name"];
    _workPhone = [Component valueForDictionary:dictionary withKey:@"work_phone"];
    _homePhone = [Component valueForDictionary:dictionary withKey:@"home_phone"];

    
    _emailAddresses = [[NSMutableArray alloc] init];
    for(NSDictionary *email in [dictionary objectForKey:@"email_addresses"])
    {
        [_emailAddresses addObject:email]; 
    }
    _addresses = [[NSMutableArray alloc] init];
    for(Address *address in [dictionary objectForKey:@"addresses"])
    {
        [_addresses addObject:address];
    }
    _customFields = [[NSMutableArray alloc] init];
    for(CustomField *field in [dictionary objectForKey:@"custom_fields"])
    {
        [_customFields addObject:field];
    }
    
    return self;
}

+ (AddContactsImportData *)AddContactsImportDatarWithDictionary:(NSDictionary *)dictionary
{
    AddContactsImportData *addImportData = [[AddContactsImportData alloc]init];
    
    addImportData.firstName = [Component valueForDictionary:dictionary withKey:@"first_name"];
    addImportData.middleName = [Component valueForDictionary:dictionary withKey:@"middle_name"];
    addImportData.lastName = [Component valueForDictionary:dictionary withKey:@"last_name"];
    addImportData.jobTitle = [Component valueForDictionary:dictionary withKey:@"job_title"];
    addImportData.companyName = [Component valueForDictionary:dictionary withKey:@"company_name"];
    addImportData.workPhone = [Component valueForDictionary:dictionary withKey:@"work_phone"];
    addImportData.homePhone = [Component valueForDictionary:dictionary withKey:@"home_phone"];
    
    
    addImportData.emailAddresses = [[NSMutableArray alloc]init];
    for(NSDictionary *email in [dictionary objectForKey:@"email_addresses"])
    {
        [addImportData.emailAddresses addObject:email];
    }
    addImportData.addresses = [[NSMutableArray alloc]init];
    for(Address *address in [dictionary objectForKey:@"addresses"])
    {
        [addImportData.addresses addObject:address];
    }
    addImportData.customFields = [[NSMutableArray alloc]init];
    for(CustomField *field in [dictionary objectForKey:@"custom_fields"])
    {
        [addImportData.customFields addObject:field];
    }
    
    return addImportData;
}

- (void)addCustomField:(CustomField *)customField
{
    [_customFields addObject:customField];
}

- (void)addAddress:(Address *)address
{
    [_addresses addObject:address];
}

- (void)addEmail:(NSString *)emailAddress
{
    [_emailAddresses addObject:emailAddress];
}

- (NSArray *)addressesForJson
{
    NSMutableArray *addresses = [[NSMutableArray alloc] initWithCapacity:self.addresses.count];
    
    for (Address *add in self.addresses)
    {
        [addresses addObject:[add proxyForJSON]];
    }
    return addresses;
}

- (NSArray *)fieldsForJson
{
    NSMutableArray *fields = [[NSMutableArray alloc] initWithCapacity:self.customFields.count];
    
    for (CustomField *field in self.customFields)
    {
        [fields addObject:[field proxyForJSON]];
    }
    return fields;
}

- (id) proxyForJson
{
    NSMutableDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                                 _firstName, @"first_name",
                                 _middleName, @"middle_name",
                                 _lastName,@"last_name",
                                 _jobTitle,@"job_title",
                                 _companyName,@"company_name",
                                 _workPhone,@"work_phone",
                                 _homePhone,@"home_phone",
                                 _emailAddresses,@"email_addresses",
                                 [self addressesForJson],@"addresses",
                                 [self fieldsForJson],@"custom_fields",
                                 nil];
    
    return dict;
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
