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
        
        NSString *nextLink = [[meta objectForKey:@"pagination"] objectForKey:@"next_link"];
    
        if(nextLink)
        {
            NSRange replaceRange = [nextLink rangeOfString:@"?"];
            int length = nextLink.length - replaceRange.location - 1;
            
            NSString *result = [nextLink substringWithRange:NSMakeRange(replaceRange.location+1,length)];

            self.next = result;
        }
    }
    return self;
}

@end
