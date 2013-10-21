//
//  AddContacts.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "AddContacts.h"

@implementation AddContacts

- (id)init
{
    if (self = [super init])
    {
        _importData = [[NSMutableArray alloc]init];
        _lists = [[NSMutableArray alloc]init];
        _columnNames = [[NSMutableArray alloc]init];
    }
    
    return self;
}

- (id)initWithContactsArray:(NSArray *)contacts andLists:(NSArray *)lists andColumnNames:(NSArray *)columnNames
{
    if (self = [super init])
    {
        if(contacts.count > 0 )
        {
            if([[contacts objectAtIndex:0] isKindOfClass:[AddContactsImportData class]])
                _importData = [[NSMutableArray alloc]initWithArray:contacts];
        }
        
        _lists = [[NSMutableArray alloc]initWithArray:lists];
        _columnNames = [[NSMutableArray alloc]initWithArray:columnNames];
        
        // attempt to determine the column names being used if they are not provided
        if(columnNames.count == 0)
        {
             NSMutableArray *usedColumns  = [(NSMutableArray*)[Config valueForType:@"activities_columns" key:@"email"] mutableCopy];
            
            
            Contact *contact = [contacts objectAtIndex:0];
            
            if(contact.firstName.length > 0)
            {
                [usedColumns addObject:[Config valueForType:@"activities_columns" key:@"first_name"]];
            }
            if(contact.middleName.length > 0)
            {
                [usedColumns addObject:[Config valueForType:@"activities_columns" key:@"middle_name"]];
            }
            if(contact.lastName.length > 0)
            {
                [usedColumns addObject:[Config valueForType:@"activities_columns" key:@"last_name"]];
            }
            if(contact.jobTitle.length > 0)
            {
                [usedColumns addObject:[Config valueForType:@"activities_columns" key:@"job_title"]];
            }
            if(contact.companyName.length > 0)
            {
                [usedColumns addObject:[Config valueForType:@"activities_columns" key:@"company_name"]];
            }
            if(contact.workPhone.length > 0)
            {
                [usedColumns addObject:[Config valueForType:@"activities_columns" key:@"work_phone"]];
            }
            if(contact.homePhone.length > 0)
            {
                [usedColumns addObject:[Config valueForType:@"activities_columns" key:@"home_phone"]];
            }
        
            // Addresses
            Address *address = [contact.addresses objectAtIndex:0];
        
            if(address.line1.length > 0)
            {
                [usedColumns addObject:[Config valueForType:@"activities_columns" key:@"address1"]];
            }
            if(address.line2.length > 0)
            {
                [usedColumns addObject:[Config valueForType:@"activities_columns" key:@"address2"]];
            }
            if(address.line3.length > 0)
            {
                [usedColumns addObject:[Config valueForType:@"activities_columns" key:@"address3"]];
            }
            if(address.city.length > 0)
            {
                [usedColumns addObject:[Config valueForType:@"activities_columns" key:@"city"]];
            }
            if(address.stateCode.length > 0)
            {
                [usedColumns addObject:[Config valueForType:@"activities_columns" key:@"state"]];
            }
            if(address.stateProvince.length > 0)
            {
                [usedColumns addObject:[Config valueForType:@"activities_columns" key:@"state_province"]];
            }
            if(address.postalCode.length > 0)
            {
                [usedColumns addObject:[Config valueForType:@"activities_columns" key:@"postal_code"]];
            }
            if(address.subPostalCode.length > 0)
            {
                [usedColumns addObject:[Config valueForType:@"activities_columns" key:@"sub_postal_code"]];
            }
            // Custom Fields
            for (CustomField *field in contact.customFields)
            {
               if ([field.name rangeOfString:@"Custom Field "].location != NSNotFound)
               {
                  int max = field.name.length - 13;
                  NSString *result = [field.name substringWithRange:NSMakeRange(13, max)];
                  [usedColumns addObject:[Config valueForType:@"activities_columns" key:[NSString stringWithFormat:@"custom_field_%@",result]]];
               }
            }
        
            _columnNames = [NSArray arrayWithArray:usedColumns];
        
        }
    }
    return self;
}

- (id) proxyForJson
{
    NSMutableArray *temp = [[NSMutableArray alloc]init];
    for(int i = 0 ; i < _importData.count ; i++)
    {
        AddContactsImportData * dat = [_importData objectAtIndex:i];
        [temp addObject:[dat proxyForJson]];
    }
    
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                                 temp, @"import_data",
                                 _lists, @"lists",
                                 _columnNames,@"column_names",
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
