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
        _noteId = @"";
        _note = @"";
        _createdDate = @"";
    }
    
    return self;
}


- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _noteId = [Component valueForDictionary:dictionary withKey:@"id"];
        _note = [Component valueForDictionary:dictionary withKey:@"note"];
        _createdDate = [Component valueForDictionary:dictionary withKey:@"created_date"];
    }
    
    return self;
}

+ (Note *)NoteWithDictionary:(NSDictionary *)dictionary;
{
    Note *note = [[Note alloc] initWithDictionary:dictionary];
    
    return note;
}

- (NSDictionary*)proxyForJSON
{
    NSDictionary *dictForJSON = [NSDictionary dictionaryWithObjectsAndKeys:
                                 self.note, @"note",
                                 nil];
    return dictForJSON;
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
