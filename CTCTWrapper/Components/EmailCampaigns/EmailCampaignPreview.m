//
//  EmailCampaignPreview.m
//  ConstantContact
//
//  Copyright (c) 2013 ConstantContact. All rights reserved.
//

#import "EmailCampaignPreview.h"

static NSString * const kFrom_email = @"from_email";
static NSString * const kReply_to_email = @"reply_to_email";
static NSString * const kSubject = @"subject";
static NSString * const kPreview_email_content = @"preview_email_content";
static NSString * const kPreview_text_content = @"preview_text_content";

@implementation EmailCampaignPreview

- (id)init
{
    if (self = [super init])
    {
        _fromEmail = @"";
        _replyToEmail = @"";
        _subject = @"";
        _previewEmailContent = @"";
        _previewTextContent = @"";
    }
    
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _fromEmail = dictionary[kFrom_email];
        _replyToEmail = dictionary[kReply_to_email];
        _subject = dictionary[kSubject];
        _previewEmailContent = dictionary[kPreview_email_content];
        _previewTextContent = dictionary[kPreview_text_content];
    }
    return self;
}

+ (EmailCampaignPreview *)emailCampaignPreviewWithDictionary:(NSDictionary *)dictionary
{
    EmailCampaignPreview *emailCampaignPreview = [[EmailCampaignPreview alloc] initWithDictionary:dictionary];
    
    return emailCampaignPreview;
}

- (NSDictionary*)proxyForJSON
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    if (_fromEmail) dict[kFrom_email] = _fromEmail;
    if (_replyToEmail) dict[kReply_to_email] = _replyToEmail;
    if (_subject) dict[kSubject] = _subject;
    if (_previewEmailContent) dict[kPreview_email_content] = _previewEmailContent;
    if (_previewTextContent) dict[kPreview_text_content] = _previewTextContent;
    
    return dict;
}

- (NSString*)JSON
{
    NSDictionary *jsonDict = [self proxyForJSON];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *jsonString = @"";
    
    if (!jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    return jsonString;
}

@end
