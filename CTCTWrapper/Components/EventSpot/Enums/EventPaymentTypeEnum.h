//
//  EventPaymentTypeEnum.h
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventPaymentTypeEnum : NSObject

@property (strong, nonatomic, readonly) NSString * onlineCreditCardProcesor; //not supported for new events starting November 2013
@property (strong, nonatomic, readonly) NSString * payPal;
@property (strong, nonatomic, readonly) NSString * googleCheckout;
@property (strong, nonatomic, readonly) NSString * check;
@property (strong, nonatomic, readonly) NSString * door;

@end
