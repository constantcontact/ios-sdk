//
//  Config.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "Config.h"

@implementation Config

+ (NSString*)valueForType:(NSString*)type key:(NSString*)key
{
    NSString *value;
    
    NSString *configPath = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"plist"];
    NSDictionary *configDict = [NSDictionary dictionaryWithContentsOfFile:configPath];
    NSDictionary *typeDict = [configDict objectForKey:type];
    
    value = [typeDict objectForKey:key];
    
    return value;
}

@end
