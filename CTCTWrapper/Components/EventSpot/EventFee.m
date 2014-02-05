//
//  EventFee.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "EventFee.h"

@implementation EventFee

- (id)init
{
    if (self = [super init])
    {
        _feeScopeEnum = [[FeeScopeEnum alloc]init];
        
        _earlyFee = 0;
        _fee = 0;
        _feeScope = @"";
        _feeId = @"";
        _label = @"";
        _lateFee = 0;

    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _feeScopeEnum = [[FeeScopeEnum alloc]init];
        
        _earlyFee = [[Component valueForDictionary:dictionary withKey:@"early_fee"] doubleValue];
        _fee = [[Component valueForDictionary:dictionary withKey:@"fee"] doubleValue];
        _feeScope = [Component valueForDictionary:dictionary withKey:@"fee_scope"];
        _feeId = [Component valueForDictionary:dictionary withKey:@"id"];
        _label = [Component valueForDictionary:dictionary withKey:@"label"];
        _lateFee = [[Component valueForDictionary:dictionary withKey:@"late_fee"] doubleValue];
    }
    
    return self;
}

+ (EventFee *)eventFeeWithDictionary:(NSDictionary *)dictionary
{
    EventFee *eventFee = [[EventFee alloc] initWithDictionary:dictionary];
    
    return eventFee;
}

-(NSDictionary*)proxyForJSON
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    if(_earlyFee)[dict setObject: [NSNumber numberWithDouble:_earlyFee] forKey:@"early_fee"];
    if(_fee)[dict setObject:[NSNumber numberWithDouble:_fee] forKey:@"fee"];
    if(_feeScope)[dict setObject:_feeScope forKey:@"fee_scope"];
    if(_label)[dict setObject:_label forKey:@"label"];
    if(_lateFee)[dict setObject:[NSNumber numberWithDouble:_lateFee] forKey:@"late_fee"];
    
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
