//
//  TrackingSummary.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "TrackingSummary.h"

@implementation TrackingSummary

- (id)init
{
    if (self = [super init])
    {
        _sends = @"";
        _opens = @"";
        _clicks = @"";
        _forwards = @"";
        _bounces = @"";
        _unsubscribes = @"";
    }
    
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _sends = [Component valueForDictionary:dictionary withKey:@"sends"];
        _opens = [Component valueForDictionary:dictionary withKey:@"opens"];
        _clicks = [Component valueForDictionary:dictionary withKey:@"clicks"];
        _forwards = [Component valueForDictionary:dictionary withKey:@"forwards"];
        _bounces = [Component valueForDictionary:dictionary withKey:@"bounces"];
        _unsubscribes = [Component valueForDictionary:dictionary withKey:@"unsubscribes"];
    }
    return self;
}

+ (TrackingSummary *)trackingSummaryWithDictionary:(NSDictionary *)dictionary;
{
    TrackingSummary *trackingSummary = [[TrackingSummary alloc]init];
    
    trackingSummary.sends = [Component valueForDictionary:dictionary withKey:@"sends"];
    trackingSummary.opens = [Component valueForDictionary:dictionary withKey:@"opens"];
    trackingSummary.clicks = [Component valueForDictionary:dictionary withKey:@"clicks"];
    trackingSummary.forwards = [Component valueForDictionary:dictionary withKey:@"forwards"];
    trackingSummary.bounces = [Component valueForDictionary:dictionary withKey:@"bounces"];
    trackingSummary.unsubscribes = [Component valueForDictionary:dictionary withKey:@"unsubscribes"];

    return trackingSummary;
}

@end
