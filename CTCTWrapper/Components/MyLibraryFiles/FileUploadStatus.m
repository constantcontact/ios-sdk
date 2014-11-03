//
//  FileUploadStatus.m
//  CTCTContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "FileUploadStatus.h"

@implementation FileUploadStatus

- (id)init
{
    if (self = [super init])
    {
        _fileId =  @"";
        _status = @"";
        _desc = @"";
    }
    
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _fileId = [Component valueForDictionary:dictionary withKey:@"description"];
        _status = [Component valueForDictionary:dictionary withKey:@"file_id"];
        _desc = [Component valueForDictionary:dictionary withKey:@"status"];
    }
    return self;
}

+ (FileUploadStatus *)fileUploadStatusWithDictionary:(NSDictionary *)dictionary;
{
    FileUploadStatus *status = [[FileUploadStatus alloc] initWithDictionary:dictionary];
    
    return status;
}

@end
