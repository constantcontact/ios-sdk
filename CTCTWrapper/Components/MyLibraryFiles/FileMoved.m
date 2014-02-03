//
//  FileMoved.m
//  CTCTContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "FileMoved.h"

@implementation FileMoved

- (id)init
{
    if (self = [super init])
    {
        _fileID =  @"";
        _uri = @"";
    }
    
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _fileID = [Component valueForDictionary:dictionary withKey:@"id"];
        _uri = [Component valueForDictionary:dictionary withKey:@"uri"];
    }
    return self;
}

+ (FileMoved *)fileMovementWithDictionary:(NSDictionary *)dictionary;
{
    FileMoved *moved = [[FileMoved alloc] initWithDictionary:dictionary];
    
    return moved;
}
@end
