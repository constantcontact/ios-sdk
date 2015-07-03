//
//  EmailCampaignPreview.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Component.h"

/**
 * Represents a campaign email preview in Constant Contact
 *
 */
@interface EmailCampaignPreview : NSObject
/**
 * The email address the email campaign originated from
 *
 * @var NSString
 */
@property (nonatomic, strong) NSString *fromEmail;

/**
 * The reply-to email address for the email campaign
 *
 * @var NSString
 */
@property (nonatomic, strong) NSString *replyToEmail;

/**
 * The subject line content for the message
 *
 * @var NSString
 */
@property (nonatomic, strong) NSString *subject;

/**
 * The preview of the rendered HTML version of the email campaign message
 *
 * @var NSString
 */
@property (nonatomic, strong) NSString *previewEmailContent;

/**
 * The preview of the text-only version of the email campaign message
 *
 * @var NSString
 */
@property (nonatomic, strong) NSString *previewTextContent;

/**
 * Factory method to create a EmailCampaignPreview object from an Dictionary
 *
 * @param NSDictionary *dictionary - associative dictionary of initial properties to set
 *
 * @return EmailCampaignPreview *
 */

+ (EmailCampaignPreview *)emailCampaignPreviewWithDictionary:(NSDictionary *)dictionary;

/**
 * Create json used for a POST/PUT request, also handles removing attributes that will cause errors if sent
 *
 * @return NSString
 */
- (NSString*)JSON;

@end
