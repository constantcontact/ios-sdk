//
//  EventPatch.m
//  CTCTContact
//
//  Copyright (c) 2014 Constant Contact. All rights reserved.
//

#import "EventPatch.h"

@implementation EventPatch

- (id)init
{
    if (self = [super init])
    {
       _eventPatchOpEnum = [[EventPatchOpEnum alloc]init];
       _eventPatchValueEnum = [[EventPatchValueEnum alloc]init];
       _eventPatchStatusEnum = [[EventPatchStatusEnum alloc]init];
        
        _op = @"";
        _path = @"";
        _value = @"";
    }
    return self;
}

-(NSDictionary*)proxyForJSON
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    if(_op) [dict setObject:_op forKey:@"op"];
    if(_path) [dict setObject:_path forKey:@"path"];
    if(_value) [dict setObject:_value forKey:@"value"];
    
    return dict;
}

- (NSString*)JSON
{
    NSDictionary *jsonDict = (NSDictionary *)[NSArray arrayWithObject:[self proxyForJSON]];
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
