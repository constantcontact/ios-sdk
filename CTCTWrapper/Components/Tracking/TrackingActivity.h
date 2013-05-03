//
//  TrackingActivity.h
//  ConstantContact
//

//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 * Class to wrap a result set of individual activities (ie: OpensActivity, SendActivity)
 *
 */
@interface TrackingActivity : NSObject

@property (nonatomic, strong) NSArray *results;
@property (nonatomic, strong) NSString *next;

/**
 * Constructor to create a TrackingActivity from the results/pagination response from getting a set of activities
 *
 * @param NSDictionary *results - results dictionary from a tracking endpoint
 * @param NSDictionary *pagination - pagination dictionary returned from a tracking endpoint
 */
- (void)createTrackingActivityWithResults:(NSDictionary *)results andPagination:(NSDictionary *)pagination;



@end
