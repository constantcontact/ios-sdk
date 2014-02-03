//
//  FileMoved.h
//  CTCTContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Component.h"

@interface FileMoved : NSObject

@property (strong, nonatomic) NSString *fileID;
@property (strong, nonatomic) NSString *uri;

- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (FileMoved *)fileMovementWithDictionary:(NSDictionary *)dictionary;

@end
