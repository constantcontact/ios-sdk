//
//  RegistrantPromocodeInfo.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "RegistrantPromocodeInfo.h"

@implementation RegistrantPromocodeInfo

- (id)init
{
    if (self = [super init])
    {
        _discountTypeEnum = [[PromocodeDiscountTypeEnum alloc]init];
        _eventRegistrantDiscountScopeEnum = [[EventRegistrantDiscountScopeEnum alloc]init];
        
       _discountType = @"";
       _codeName = @"";
       _redemptionCount = 0;
       _discoutScope = @"";
       _discountAmount = 0;
       _discountPercent = 0;
       _codeType = @"";
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _discountTypeEnum = [[PromocodeDiscountTypeEnum alloc]init];
        _eventRegistrantDiscountScopeEnum = [[EventRegistrantDiscountScopeEnum alloc]init];
        
        _discountType = [Component valueForDictionary:dictionary withKey:@"discount_type"];
        _codeName = [Component valueForDictionary:dictionary withKey:@"code_name"];
        _redemptionCount = [[Component valueForDictionary:dictionary withKey:@"redemption_count"] integerValue];
        _discoutScope = [Component valueForDictionary:dictionary withKey:@"discount_scope"];
        _discountAmount = [[Component valueForDictionary:dictionary withKey:@"discount_amount"] doubleValue];
        _discountPercent = [[Component valueForDictionary:dictionary withKey:@"discount_percent"] doubleValue];
        _codeType = [Component valueForDictionary:dictionary withKey:@"code_type"];
    }
    
    return self;
}

+ (RegistrantPromocodeInfo *)promocodeInfoWithDictionary:(NSDictionary *)dictionary
{
    RegistrantPromocodeInfo *promocodeInfo = [[RegistrantPromocodeInfo alloc] initWithDictionary:dictionary];
    
    return promocodeInfo;
}

-(NSDictionary*)proxyForJSON
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    if(_discountType) [dict setObject:_discountType forKey:@"discount_type"];
    if(_codeName) [dict setObject:_codeName forKey:@"code_name"];
    if(_redemptionCount) [dict setObject:[NSNumber numberWithInt:_redemptionCount] forKey:@"redemption_count"];
    if(_discoutScope) [dict setObject:_discoutScope forKey:@"discount_scope"];
    if(_discountAmount) [dict setObject: [NSNumber numberWithDouble:_discountAmount] forKey:@"discount_amount"];
    if(_discountPercent) [dict setObject:[NSNumber numberWithDouble:_discountPercent]  forKey:@"discount_percent"];
    if(_codeType) [dict setObject:_codeType forKey:@"code_type"];
    
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
