//
//  Thumbnail.h
//  CTCTContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Component.h"

@interface Thumbnail : NSObject

@property (nonatomic, readwrite) int          height;
@property (nonatomic, strong) NSString        *url;
@property (nonatomic, readwrite) int          width;

- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (Thumbnail *)thumbnailWithDictionary:(NSDictionary *)dictionary;

@end
