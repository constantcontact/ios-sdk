//
//  LibraryFile.h
//  CTCTContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Thumbnail.h"
#import "Component.h"

@interface LibraryFile : NSObject

@property (nonatomic, strong) NSString   *createdDate;
@property (nonatomic, strong) NSString   *description;
@property (nonatomic, strong) NSString   *fileType;
@property (nonatomic, strong) NSString   *folder;
@property (nonatomic, strong) NSString   *folderId;
@property (nonatomic, readwrite) int     height;
@property (nonatomic, strong, readonly) NSString   *fileId;
@property (nonatomic, readwrite) BOOL    isImage;
@property (nonatomic, strong) NSString   *modifiedDate;
@property (nonatomic, strong) NSString   *name;
@property (nonatomic, readwrite) int     size;
@property (nonatomic, strong) NSString   *source;
@property (nonatomic, strong) NSString   *status;
@property (nonatomic, strong) Thumbnail  *thumbnail;
@property (nonatomic, strong) NSString   *url;
@property (nonatomic, readwrite) int     width;

- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (LibraryFile *)fileWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary*)proxyForJSON;
- (NSString *)JSON;

@end
