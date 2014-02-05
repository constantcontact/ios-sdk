//
//  PromocodeStatusEnum.h
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PromocodeStatusEnum : NSObject

@property (strong, nonatomic, readonly) NSString * live;
@property (strong, nonatomic, readonly) NSString * paused;
@property (strong, nonatomic, readonly) NSString * depleted;

@end
