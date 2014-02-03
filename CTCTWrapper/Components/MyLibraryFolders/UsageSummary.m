//
//  UsageSummary.m
//  CTCTContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "UsageSummary.h"

@implementation UsageSummary

- (id)init
{
    if (self = [super init])
    {
        _folderCount = 0;
        _fileCount = 0;
        _imageCount = 0;
        _documentCount = 0;
        _totalBytesCount = 0;
        _imageBytesCount = 0;
        _documentBytesUsed = 0;
        _totalBytesRemaining = 0;
        _freeFilesRemaining = 0;
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _folderCount = [[Component valueForDictionary:dictionary withKey:@"folder_count"] intValue];
        _fileCount = [[Component valueForDictionary:dictionary withKey:@"file_count"] intValue];
        _imageCount = [[Component valueForDictionary:dictionary withKey:@"image_count"] intValue];
        _documentCount = [[Component valueForDictionary:dictionary withKey:@"document_count"] intValue];
        _totalBytesCount = [[Component valueForDictionary:dictionary withKey:@"total_bytes_used"] intValue];
        _imageBytesCount = [[Component valueForDictionary:dictionary withKey:@"image_bytes_used"] intValue];
        _documentBytesUsed = [[Component valueForDictionary:dictionary withKey:@"document_bytes_used"] intValue];
        _totalBytesRemaining = [[Component valueForDictionary:dictionary withKey:@"total_bytes_remaining"] intValue];
        _freeFilesRemaining = [[Component valueForDictionary:dictionary withKey:@"free_files_remaining"] intValue];
    }
    return self;
}

+ (UsageSummary *)usageSummaryWithDictionary:(NSDictionary *)dictionary
{
    UsageSummary *summary = [[UsageSummary alloc] initWithDictionary:dictionary];
    
    return summary;
}

@end
