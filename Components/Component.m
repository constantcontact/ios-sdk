//
//  Component.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "Component.h"

@implementation Component

+(NSString*)valueForDictionary:(NSDictionary*)dictionary withKey:(NSString*)key
{
    return [dictionary objectForKey:key];
}

@end
