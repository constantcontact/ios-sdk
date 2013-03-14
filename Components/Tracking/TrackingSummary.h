//
//  TrackingSummary.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Component.h"

/**
 * Represents a Tracking Summary
 *
 */
@interface TrackingSummary : NSObject

@property (nonatomic, strong) NSString *sends;
@property (nonatomic, strong) NSString *opens;
@property (nonatomic, strong) NSString *clicks;
@property (nonatomic, strong) NSString *forwards;
@property (nonatomic, strong) NSString *unsubscribes;
@property (nonatomic, strong) NSString *bounces;

/**
 * Factory method to create a TrackingSummary object from an dictionary
 *
 * @param NSDictionary *dictionary - dictionary of properties to create object from
 *
 * @return TrackingSummary *
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (TrackingSummary *)trackingSummaryWithDictionary:(NSDictionary *)dictionary;

@end
