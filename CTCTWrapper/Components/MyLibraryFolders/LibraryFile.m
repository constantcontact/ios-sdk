//
//  LibraryFile.m
//  CTCTContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "LibraryFile.h"

@implementation LibraryFile

- (id)init
{
    if (self = [super init])
    {
        _createdDate = @"";
        _desc = @"";
        _fileType = @"";
        _folder = @"";
        _folderId = @"";
        _height = 0;
        _fileId = @"";
        _isImage = 0;
        _modifiedDate = @"";
        _name = @"";
        _size = 0;
        _source = @"";
        _status = @"";
        _thumbnail = [[Thumbnail alloc] init];
        _url = @"";
        _width = 0;
    }
    
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _createdDate = [Component valueForDictionary:dictionary withKey:@"created_date"];
        _desc = [Component valueForDictionary:dictionary withKey:@"description"];
        _fileType = [Component valueForDictionary:dictionary withKey:@"file_type"];
        _folder = [Component valueForDictionary:dictionary withKey:@"folder"];
        _folderId = [Component valueForDictionary:dictionary withKey:@"folder_id"];
        _height = [[Component valueForDictionary:dictionary withKey:@"height"] intValue];
        _fileId = [Component valueForDictionary:dictionary withKey:@"id"];
        _isImage = [[Component valueForDictionary:dictionary withKey:@"is_image"] intValue];
        _modifiedDate = [Component valueForDictionary:dictionary withKey:@"modified_date"];
        _name = [Component valueForDictionary:dictionary withKey:@"name"];
        _size = [[Component valueForDictionary:dictionary withKey:@"size"] intValue];
        _source = [Component valueForDictionary:dictionary withKey:@"source"];
        _status = [Component valueForDictionary:dictionary withKey:@"status"];
        _thumbnail = [[Thumbnail alloc] initWithDictionary:[dictionary objectForKey:@"thumbnail"]];
        _url = [Component valueForDictionary:dictionary withKey:@"url"];
        _width = [[Component valueForDictionary:dictionary withKey:@"width"] intValue];
    }
    return self;
}

+ (LibraryFile *)fileWithDictionary:(NSDictionary *)dictionary;
{
    LibraryFile *libFile = [[LibraryFile alloc] initWithDictionary:dictionary];
    
    return libFile;
}

- (NSDictionary*)proxyForJSON
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            _folderId, @"folder_id",
            _desc, @"description",
            _name, @"name",
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
