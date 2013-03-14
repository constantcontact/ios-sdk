//
//  ExportContacts.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "ExportContacts.h"

@implementation ExportContacts

- (id)init
{
    if (self = [super init])
    {
        _fileType = @"CSV";
        _sortBy = @"EMAIL_ADDRESS";
        _exportDateAdded = YES;
        _exportAddedBy = YES;
        _lists = [[NSMutableArray alloc]init];
        _columnNames = [[NSMutableArray alloc]initWithObjects:@"Email Address", @"First Name", @"Last Name", nil];
    }
    
    return self;
}

- (id)initWithListsArray:(NSArray *)lists
{
    if (self = [super init])
    {
        if (lists.count > 0)
        {
            _lists = [[NSMutableArray alloc]initWithArray:lists];
        }
    }
    return self;
}

- (id)proxyForJson
{
    
    NSMutableDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys: _fileType, @"file_type", _sortBy, @"sort_by",[NSNumber numberWithBool:_exportDateAdded],@"export_date_added",[NSNumber numberWithBool:_exportAddedBy],@"export_added_by",_lists,@"lists",_columnNames,@"column_names", nil];
    
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
