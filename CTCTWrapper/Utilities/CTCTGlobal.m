//
//  CTCTGlobal.m
//  CTCTContact
//
//  Created by Sergiu Grigoriev on 3/28/13.
//  Copyright (c) 2013 OSF Global. All rights reserved.
//

#import "CTCTGlobal.h"

@implementation CTCTGlobal

+ (CTCTGlobal*)shared {
    static CTCTGlobal *singleton = nil;
    
    @synchronized(self)
    {
        if (!singleton) {
            singleton = [[CTCTGlobal alloc] init];
        }
    }
    return singleton;
}

- (id)init
{
    if (self = [super init])
    {
        self.token = @"";
        self.email = @"";
    }
    
    return self;
}

@end
