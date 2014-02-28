//
//  EventStatusEnum.h
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventStatusEnum : NSObject

@property (strong, nonatomic, readonly) NSString * draft;
@property (strong, nonatomic, readonly) NSString * active;
@property (strong, nonatomic, readonly) NSString * complete;
@property (strong, nonatomic, readonly) NSString * cancelled;
@property (strong, nonatomic, readonly) NSString * deleted;

@end
