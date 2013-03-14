//
//  TrackingActivity.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "TrackingActivity.h"

@implementation TrackingActivity

- (void)createTrackingActivityWithResults:(NSDictionary *)results andPagination:(NSDictionary *)pagination
{
    self.results = [results allValues];
    
    if([pagination objectForKey:@"next"])
    {
        NSString *next = [pagination objectForKey:@"next"];
        
        NSRange replaceRange = [next rangeOfString:@"&next="];
        int length = next.length - replaceRange.length + 6;
        
        NSString *result = [next substringWithRange:NSMakeRange(replaceRange.location + 6,length)];
        
        self.next = result;
    }
}

@end
