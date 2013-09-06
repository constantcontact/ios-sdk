//
//  Config.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Config : NSObject

+ (NSString*)valueForType:(NSString*)type key:(NSString*)key;

@end
