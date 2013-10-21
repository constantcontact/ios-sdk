//
//  MessageFooter.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "MessageFooter.h"

@implementation MessageFooter

- (id)init
{
    if (self = [super init])
    {
        _city = @"";
        _state = @"";
        _country = @"";
        _organizationMame = @"";
        _addressLine1 = @"";
        _addressLine2 = @"";
        _addressLine3 = @"";
        _internationalState = @"";
        _postalCode = @"";
        _includeForwardEmail = NO;
        _forwardEmailLinkText = @"";
        _includeSubscribeLink = NO;
        _subscribeLinkText = @"";
    }
    
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _city =[Component valueForDictionary:dictionary withKey:@"city"];
        _state = [Component valueForDictionary:dictionary withKey:@"state"];
        _country = [Component valueForDictionary:dictionary withKey:@"country"];
        _organizationMame = [Component valueForDictionary:dictionary withKey:@"organization_name"];
        _addressLine1 = [Component valueForDictionary:dictionary withKey:@"address_line_1"];
        _addressLine2 = [Component valueForDictionary:dictionary withKey:@"address_line_2"];;
        _addressLine3 = [Component valueForDictionary:dictionary withKey:@"address_line_3"];
        _internationalState = [Component valueForDictionary:dictionary withKey:@"international_state"];
        _postalCode = [Component valueForDictionary:dictionary withKey:@"postal_code"];
        _includeForwardEmail = [[Component valueForDictionary:dictionary withKey:@"include_forward_email"]boolValue];
        _forwardEmailLinkText = [Component valueForDictionary:dictionary withKey:@"forward_email_link_text"];
        _includeSubscribeLink = [[Component valueForDictionary:dictionary withKey:@"include_subscribe_link"]boolValue];
        _subscribeLinkText = [Component valueForDictionary:dictionary withKey:@"subscribe_link_text"];
    }
    return self;
}

+ (MessageFooter *)messageFooterWithDictionary:(NSDictionary *)dictionary;
{
    MessageFooter *messageFooter = [[MessageFooter alloc] initWithDictionary:dictionary];
    
    return messageFooter;
}

- (NSDictionary*)proxyForJSON
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 _city, @"city",
                                 _state, @"state",
                                 _country, @"country",
                                 _organizationMame, @"organization_name",
                                 _addressLine1,@"address_line_1",
                                 _addressLine2,@"address_line_2",
                                 _addressLine3,@"address_line_3",
                                 _internationalState,@"international_state",
                                 _postalCode,@"postal_code",
                                 [NSNumber numberWithBool:_includeForwardEmail],@"include_forward_email",
                                 _forwardEmailLinkText,@"forward_email_link_text",
                                 [NSNumber numberWithBool:_includeSubscribeLink],@"include_subscribe_link",
                                 _subscribeLinkText,@"subscribe_link_text",
                                 nil];
    
    return dict;
}

- (NSString *)JSON
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
