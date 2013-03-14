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
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *status;

- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (ContactList *)contactListWithDictionary:(NSDictionary *)dictionary;

- (NSString *) toJson;
- (NSString *) toJsonCampaigns;
- (id) proxyForJson;
@end
