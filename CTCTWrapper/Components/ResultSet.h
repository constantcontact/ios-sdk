//
//  ResultSet.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 * Container for a get on a collection, such as Contacts, Campaigns, or TrackingData.
 *
 */
@interface ResultSet : NSObject

/**
 * array of result objects returned
 *
 * @var NSArray
 */
@property (nonatomic, strong) NSArray *results;

/**
 * next link returned from a get on a collection if one exists
 *
 * @var NSString
 */
@property (nonatomic, strong) NSString *next;

/**
 * Constructor to create a ResultSet from the results/meta response when performing a get on a collection
 *
 * @param NSArray *results - results array from request
 * @param NSDictionary *meta - meta dictionary from request
 */
- (id)initResultSetWithResults:(NSArray *)results andMeta:(NSDictionary *)meta;

@end
