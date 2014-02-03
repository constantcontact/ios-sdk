//
//  LibrarySummary.m
//  CTCTContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "LibrarySummary.h"

@implementation LibrarySummary

- (id)init
{
    if (self = [super init])
    {
        _maxFreeFileNum = 0;
        _maxPremiumSpaceLimit = 0;
        _imageRoot = 0;
        _usageSummary = [[UsageSummary alloc]init];
        _madUploadSizeLimit = 0;
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _maxFreeFileNum = [[Component valueForDictionary:dictionary withKey:@"max_free_file_num"] intValue];
        _maxPremiumSpaceLimit = [[Component valueForDictionary:dictionary withKey:@"max_premium_space_limit"] intValue];
        _imageRoot = [[Component valueForDictionary:dictionary withKey:@"image_root"] intValue];
        _usageSummary = [UsageSummary usageSummaryWithDictionary:[dictionary objectForKey:@"usage_summary"]];
        _madUploadSizeLimit = [[Component valueForDictionary:dictionary withKey:@"max_upload_size_limit"] intValue];
    }
    return self;
}

+ (LibrarySummary *)librarySummaryWithDictionary:(NSDictionary *)dictionary;
{
    LibrarySummary *summary = [[LibrarySummary alloc] initWithDictionary:dictionary];
    
    return summary;
}

@end
