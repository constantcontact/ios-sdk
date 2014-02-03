//
//  LibrarySummary.h
//  CTCTContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UsageSummary.h"
#import "Component.h"

@interface LibrarySummary : NSObject

@property (nonatomic, readwrite) int       maxFreeFileNum;
@property (nonatomic, readwrite) int       maxPremiumSpaceLimit;
@property (nonatomic, readwrite) int       imageRoot;
@property (nonatomic, strong) UsageSummary *usageSummary;
@property (nonatomic, readwrite) int       madUploadSizeLimit;

- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (LibrarySummary *)librarySummaryWithDictionary:(NSDictionary *)dictionary;

@end
