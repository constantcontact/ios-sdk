//
//  ResultSet.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "ResultSet.h"

@implementation ResultSet

- (id)initResultSetWithResults:(NSArray *)results andMeta:(NSDictionary *)meta
{
    if (self = [super init])
    {
        self.results = [results mutableCopy];
    
        if([[meta objectForKey:@"pagination"] objectForKey:@"next_link"])
        {
        NSString *nextLink = [[meta objectForKey:@"pagination"] objectForKey:@"next_link"];
        
        NSRange replaceRange = [nextLink rangeOfString:@"?"];
        int length = nextLink.length - replaceRange.length;
        
        NSString *result = [nextLink substringWithRange:NSMakeRange(replaceRange.location,length)];

        self.next = result;
        }
    }
    return self;
}

@end
