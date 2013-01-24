//
//  CustomField.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Component.h"

@interface CustomField : NSObject

@property (nonatomic, assign) NSString *name;
@property (nonatomic, assign) NSString *value;

-(id)initWithDictionary:(NSDictionary *)dictionary;
+(CustomField*)customFieldWithDictionary:(NSDictionary *)dictionary;

@end
