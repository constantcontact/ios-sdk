//
//  UsageSummary.h
//  CTCTContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Component.h"

@interface UsageSummary : NSObject

@property (nonatomic, readwrite) int folderCount;
@property (nonatomic, readwrite) int fileCount;
@property (nonatomic, readwrite) int imageCount;
@property (nonatomic, readwrite) int documentCount;
@property (nonatomic, readwrite) int totalBytesCount;
@property (nonatomic, readwrite) int imageBytesCount;
@property (nonatomic, readwrite) int documentBytesUsed;
@property (nonatomic, readwrite) int totalBytesRemaining;
@property (nonatomic, readwrite) int freeFilesRemaining;

- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (UsageSummary *)usageSummaryWithDictionary:(NSDictionary *)dictionary;

@end
