//
//  RegistrantOrder.h
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RegistrantSaleItem.h"
#import "RegistrantFee.h"
#import "Component.h"

@interface RegistrantOrder : NSObject

/**
 * Total order value
 */
@property (nonatomic, readwrite) double total;
/**
 * Currency type used
 */
@property (nonatomic, strong) NSString *currencyType;
/**
 * Date and time the order was placed.
 */
@property (nonatomic, strong) NSString *orderDate;
/**
 * Order ID
 */
@property (nonatomic, strong) NSString *orderId;
/**
 * Array containing all the fees in a order
 */
@property (nonatomic, strong) NSMutableArray *fees;
/**
 * Array containing all the items in a order
 */
@property (nonatomic, strong) NSMutableArray *items;

/**
 * Factory method to create a Registrant Order object from an dictionary
 *
 * @param NSDictionary *dictionary - associative dictionary of initial properties to set
 *
 * @return RegistrantOrder
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (RegistrantOrder *)registrantOrderWithDictionary:(NSDictionary *)dictionary;

- (NSString*)JSON;

@end
