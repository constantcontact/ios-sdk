//
//  FileUploadStatus.h
//  CTCTContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Component.h"

@interface FileUploadStatus : NSObject

@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *fileId;
@property (strong, nonatomic) NSString *status;

- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (FileUploadStatus *)fileUploadStatusWithDictionary:(NSDictionary *)dictionary;

@end
