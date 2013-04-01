//
//  TestSend.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Component.h"

/**
 * Represents a campaign Test Send in Constant Contact
 *
 */
@interface TestSend : NSObject
/**
 * Format of the email to send (HTML, TEXT, HTML_AND_TEXT)
 *
 * @var NSString
 */
@property (nonatomic, strong) NSString *format;

/**
 * Personal message to send along with the test send
 *
 * @var NSString
 */
@property (nonatomic, strong) NSString *personalMessage;

/**
 * Array of email addresses to send the test send to
 *
 * @var NSMutableArray
 */
@property (nonatomic, strong) NSMutableArray *emailAddresses;

/**
 * Factory method to create a TestSend object from an dictionary
 *
 * @param NSDictionary *dictionary - associative dictionary of initial properties to set
 *
 * @return TestSend *
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (TestSend *)testSendWithDictionary:(NSDictionary *)dictionary;

/**
 * Add an email address to the set of addresses to send the test send too
 *
 * @param NSString
 */
- (void)addEmailToEmailAddresses:(NSString *)emailAddress;

/**
 * Create json used for a POST/PUT request, also handles removing attributes that will cause errors if sent
 *
 * @return NSString
 */
- (NSString*)JSON;

@end
