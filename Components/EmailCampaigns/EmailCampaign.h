//
//  EmailCampaigns.h
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Component.h"
#import "Config.h"
#import "MessageFooter.h"
#import "TrackingSummary.h"
#import "ClickThroughDetails.h"
#import "ContactList.h"

/**
 * Represents a single Campaign in Constant Contact
 *
 */
@interface EmailCampaign : NSObject

@property (nonatomic, readonly) NSString *campaignId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *fromName;
@property (nonatomic, strong) NSString *fromEmail;
@property (nonatomic, strong) NSString *replyToEmail;
@property (nonatomic, strong) NSString *campaignType;
@property (nonatomic, strong) NSString *createdDate;
@property (nonatomic, strong) NSString *modifiedDate;
@property (nonatomic, strong) NSString *lastSendDate;
@property (nonatomic, strong) NSString *lastRunDate;
@property (nonatomic, strong) NSString *nextRunDate;
@property (nonatomic, readwrite) BOOL isPermissionReminderEnabled;
@property (nonatomic, strong) NSString *permissionReminderText;
@property (nonatomic, readwrite) BOOL isViewAsWebpageEnabled;
@property (nonatomic, strong) NSString *viewAsWebPageText;
@property (nonatomic, strong) NSString *viewAsWebPageLinkText;
@property (nonatomic, strong) NSString *greetingSalutations;
@property (nonatomic, strong) NSString *greetingName;
@property (nonatomic, strong) NSString *greetingString;

@property (nonatomic, strong) MessageFooter *messageFooter;
@property (nonatomic, strong) TrackingSummary *trackingSummary;

@property (nonatomic, strong) NSString *emailContent;
@property (nonatomic, strong) NSString *emailContentFormat;
@property (nonatomic, strong) NSString *styleSheet;
@property (nonatomic, strong) NSString *textContent;
@property (nonatomic, strong) NSMutableArray *sentToContactLists;
@property (nonatomic, strong) NSMutableArray *clickThroughDetails;

/**
 * Factory method to create a Campaign object from an Dictionary
 *
 * @param NSDictionary *dictionary - associative dictionary of initial properties to set
 *
 * @return Campaign *
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (EmailCampaign *)emailCampaignWithDictionary:(NSDictionary *)dictionary;

/**
 * Factory method to create a Campaign object from an dictionary
 *
 * @param NSDictionary *dictionary - associative dictionary of initial properties to set
 *
 * @return EmailCampaign *
 */
+ (EmailCampaign *)createSummaryWithDictionary:(NSDictionary *)dictionary;

/**
 * Add a contact list to set of lists associated with this email
 *
 * @param id $*ontactList - Contact list id, or ContactList object
 */
- (void)addContactList:(id)contactList;

/**
 * Create json used for a POST/PUT request, also handles removing attributes that will cause errors if sent
 *
 * @return NSString *
 */
- (NSString *)JSON;
- (NSString *)minimalJSON;

@end
