//
//  LibraryFolder.m
//  CTCTContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "LibraryFolder.h"

@implementation LibraryFolder

- (id)init
{
    if (self = [super init])
    {
        _folderId = @"";
        _name = @"";
        _level = 0;
        _children = [[NSMutableArray alloc]init];
        _itemCount = 0;
        _parrentId = @"";
        _modifiedDate = @"";
        _createdDate = @"";
    }
    
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _folderId = [Component valueForDictionary:dictionary withKey:@"id"];
        _name = [Component valueForDictionary:dictionary withKey:@"name"];
        _level = [[Component valueForDictionary:dictionary withKey:@"level"] intValue];
        _itemCount = [[Component valueForDictionary:dictionary withKey:@"item_count"] intValue];
        _parrentId = [Component valueForDictionary:dictionary withKey:@"parent_id"];
        _modifiedDate = [Component valueForDictionary:dictionary withKey:@"modified_date"];
        _createdDate = [Component valueForDictionary:dictionary withKey:@"created_date"];
        
        _children = [[NSMutableArray alloc] init];
        
        for(NSDictionary *folder in [dictionary objectForKey:@"children"])
        {
            LibraryFolder *value = [LibraryFolder folderWithDictionary:folder];
            [_children addObject:value];
        }
    }
    return self;
}

+ (LibraryFolder *)folderWithDictionary:(NSDictionary *)dictionary
{
    LibraryFolder *folder = [[LibraryFolder alloc] initWithDictionary:dictionary];
    
    return folder;
}

- (NSDictionary*)proxyForJSON
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            _name, @"name",
            _parrentId, @"parent_id",
            nil];
}

- (NSString *)JSON
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
