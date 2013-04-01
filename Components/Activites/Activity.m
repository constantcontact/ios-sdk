//
//  Activity.m
//  ConstantContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "Activity.h"
#import "ActivityError.h"

@implementation Activity

- (id)init
{
    if (self = [super init])
    {
        _activityId = @"";
        _type = @"";
        _status = @"";
        _startDate = @"";
        _fileName = @"";
        _createdDate = @"";
        _finishDate = @"";
        _errorCount = @"";
        _errors = [[NSMutableArray alloc]init];
        _warnings = [[NSMutableArray alloc]init];
        _contactCount = @"";
    }
    
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _activityId = [Component valueForDictionary:dictionary withKey:@"id"];
        _type = [Component valueForDictionary:dictionary withKey:@"type"];
        _status = [Component valueForDictionary:dictionary withKey:@"status"];
        _startDate = [Component valueForDictionary:dictionary withKey:@"start_date"];
        _finishDate = [Component valueForDictionary:dictionary withKey:@"finish_date"];
        _createdDate = [Component valueForDictionary:dictionary withKey:@"created_date"];
        _errorCount = [Component valueForDictionary:dictionary withKey:@"error_count"];
        _contactCount = [Component valueForDictionary:dictionary withKey:@"contact_count"];
        
        // set any errors that exist, otherewise destroy the property
        _errors = [[NSMutableArray alloc]init];
        if( [dictionary objectForKey:@"errors"])
           for(NSDictionary *error in [dictionary objectForKey:@"errors"])
            {
                [_errors addObject:[ActivityError activityErrorWithDictionary:error]];
            }
        
         // set any warnings that exist, otherewise destroy the property 
         _warnings = [[NSMutableArray alloc]init];
        if( [dictionary objectForKey:@"warnings"])
            for(NSDictionary *warning in [dictionary objectForKey:@"warnings"])
            {
                [_warnings addObject:[ActivityError activityErrorWithDictionary:warning]];
            }
        
         // set the file name if exists
          if( [dictionary objectForKey:@"file_name"])
          {
              self.fileName = [Component valueForDictionary:dictionary withKey:@"file_name"];
          }
    }
    
    return self;
}

+ (Activity *)activityWithDictionary:(NSDictionary *)dictionary
{
    Activity *activity = [[Activity alloc] initWithDictionary:dictionary];
    
    return activity;
}

- (id) proxyForJson
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 _activityId, @"id",
                                 _type, @"type",
                                 _status,"status",
                                 _startDate,@"start_date",
                                 _finishDate,@"finish_date",
                                 _createdDate,@"created_date",
                                 _errorCount,@"error_count",
                                 _contactCount,@"contact_count",
                                 nil];
    
    if(_errors.count > 0)
       [dict setObject:_errors forKey:@"errors"];
    
    if(_warnings.count > 0)
        [dict setObject:_warnings forKey:@"warnings"];
    if(![_fileName isEqualToString:@""])
        [dict setObject:_fileName forKey:@"file_name"];
    
    return dict;
}

@end
