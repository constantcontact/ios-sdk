//
//  ContactList.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Component.h"

@interface ContactList : NSObject

@property (nonatomic, strong, readonly) NSString *listId;
@property (nonatomic, readonly) int contactCount;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *createdDate;
@property (nonatomic, strong) NSString *modifiedDate;

- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (ContactList *)contactListWithDictionary:(NSDictionary *)dictionary;

- (NSString*)JSON;
- (NSString*)JSONForMinimal;
- (NSDictionary*)proxyForMinimal;

@end
