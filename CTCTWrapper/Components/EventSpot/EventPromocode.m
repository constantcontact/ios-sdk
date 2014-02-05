//
//  EventPromocode.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "EventPromocode.h"

@implementation EventPromocode

- (id)init
{
    if (self = [super init])
    {
        _promocodeDiscountScopeEnum = [[PromocodeDiscountScopeEnum alloc]init];
        _promocodeDiscountTypeEnum = [[PromocodeDiscountTypeEnum alloc]init];
        _promocodeCodeTypeEnum = [[PromocodeCodeTypeEnum alloc]init];
        _promocodeStatusEnum = [[PromocodeStatusEnum alloc]init];
        
        _codeName = @"";
        _codeType = @"";
        _discountAmount = 0;
        _discountPercentage = 0;
        _discountScope = @"";
        _discoutType = @"";
        _feeIds = [[NSMutableArray alloc] init];
        _promocodeId = @"";
        _isPaused = FALSE;
        _quantityAvailable = 0;
        _quantityTotal = 0;
        _quantityUsed = 0;
        _status = @"";
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _promocodeDiscountScopeEnum = [[PromocodeDiscountScopeEnum alloc]init];
        _promocodeDiscountTypeEnum = [[PromocodeDiscountTypeEnum alloc]init];
        _promocodeCodeTypeEnum = [[PromocodeCodeTypeEnum alloc]init];
        _promocodeStatusEnum = [[PromocodeStatusEnum alloc]init];
        
        _codeName = [Component valueForDictionary:dictionary withKey:@"code_name"];
        _codeType = [Component valueForDictionary:dictionary withKey:@"code_type"];
        _discountAmount = [[Component valueForDictionary:dictionary withKey:@"discount_amount"] doubleValue];
        _discountPercentage = [[Component valueForDictionary:dictionary withKey:@"discount_percent"] integerValue];
        _discountScope = [Component valueForDictionary:dictionary withKey:@"discount_scope"];
        _discoutType = [Component valueForDictionary:dictionary withKey:@"discount_type"];
        _promocodeId = [Component valueForDictionary:dictionary withKey:@"id"];
        _isPaused = [[Component valueForDictionary:dictionary withKey:@"is_paused"] boolValue];
        _quantityAvailable = [[Component valueForDictionary:dictionary withKey:@"quantity_available"] integerValue];
        _quantityTotal = [[Component valueForDictionary:dictionary withKey:@"quantity_total"] integerValue];
        _quantityUsed = [[Component valueForDictionary:dictionary withKey:@"quantity_used"] integerValue];
        _status = [Component valueForDictionary:dictionary withKey:@"status"];
        
        _feeIds = [[NSMutableArray alloc] init];
        
        if([dictionary objectForKey:@"fee_ids"])
        for(NSString *idString in [dictionary objectForKey:@"fee_ids"])
        {
            [_feeIds addObject:idString];
        }
    }
    
    return self;
}

+ (EventPromocode *)promocodeWithDictionary:(NSDictionary *)dictionary
{
    EventPromocode *promocode = [[EventPromocode alloc] initWithDictionary:dictionary];
    
    return promocode;
}

-(NSDictionary*)proxyForJSON
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    if(_codeName) [dict setObject:_codeName forKey:@"code_name"];
    if(_codeType) [dict setObject:_codeType forKey:@"code_type"];
    if(_discountAmount) [dict setObject:[NSNumber numberWithDouble:_discountAmount] forKey:@"discount_amount"];
    if(_discountPercentage) [dict setObject:[NSNumber numberWithInt:_discountPercentage] forKey:@"discount_percent"];
    if(_discountScope != nil) [dict setObject:_discountScope forKey:@"discount_scope"];
    if([NSNumber numberWithBool:_isPaused] != nil) [dict setObject:[NSNumber numberWithBool:_isPaused] forKey:@"is_paused"];
    if(_quantityTotal) [dict setObject:[NSNumber numberWithInt:_quantityTotal] forKey:@"quantity_total"];
    if(_feeIds) [dict setObject:_feeIds forKey:@"fee_ids"];
    
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
