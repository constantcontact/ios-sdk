//
//  ContactList.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Component.h"

@interface ContactList : NSObject

@property (nonatomic, readwrite) int contactCount;
@property (nonatomic, assign) int id;
@property (nonatomic, assign) NSString *name;
@property (nonatomic, assign) BOOL optInDefault;
@property (nonatomic, assign) NSString *status;

-(id)initWithDictionary:(NSDictionary *)dictionary;
-(NSString*) toJson;

@end
