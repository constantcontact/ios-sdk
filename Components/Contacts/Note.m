//
//  Note.m
//  ConstantContact
//
//  Created by A_Dumitras on 2/22/13.
//  Copyright (c) 2013 Sergiu Grigoriev. All rights reserved.
//

#import "Note.h"

@implementation Note

- (id)init
{
    if (self = [super init])
    {
        _id = @"";
        _note = @"";
        _createdDate = @"";

    }
    
    return self;
}


- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _id = [Component valueForDictionary:dictionary withKey:@"id"];
        _note = [Component valueForDictionary:dictionary withKey:@"note"];
        _createdDate = [Component valueForDictionary:dictionary withKey:@"created_date"];
    }
    
    return self;
}

+ (Note *)NoteWithDictionary:(NSDictionary *)dictionary;
{
    Note *note = [[Note alloc] init];
    
    note.id = [Component valueForDictionary:dictionary withKey:@"id"];
    note.note = [Component valueForDictionary:dictionary withKey:@"note"];
    note.createdDate = [Component valueForDictionary:dictionary withKey:@"created_date"];
    
    return note;
}
@end
