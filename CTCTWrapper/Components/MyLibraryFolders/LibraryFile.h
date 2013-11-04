//
//  LibraryFile.h
//  CTCTContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Thumbnail.h"
#import "Component.h"

#define SORT_FILE_BY_CREATION_DATE @"CREATED_DATE"
#define SORT_FILE_BY_CREATION_DATE_DESCENDING @"CREATED_DATE_DESC"
#define SORT_FILE_BY_MODIFIED_DATE @" MODIFIED_DATE"
#define SORT_FILE_BY_MODIFIED_DATE_DESCENDING @"MODIFIED_DATE_DESC"
#define SORT_FILE_BY_NAME @"NAME"
#define SORT_FILE_BY_NAME_DESCENDING @"NAME_DESC"
#define SORT_FILE_BY_SIZE @"SIZE"
#define SORT_FILE_BY_SIZE_DESCENDING @"SIZE_DESC"
#define SORT_FILE_BY_DIMENSION @"DIMENSION"
#define SORT_FILE_BY_DIMENSION_DESCENDING @"DIMENSION_DESC"

#define FILE_SOURCE_ALL @"ALL"
#define FILE_SOURCE_MYCOMMPUTER @"MyComputer"
#define FILE_SOURCE_STOCKIMAGE @"StockImage"
#define FILE_SOURCE_FACEBOOK @"Facebook"
#define FILE_SOURCE_INSTAGRAM @"INSTAGRAM"
#define FILE_SOURCE_SHUTTERSTOCK @"Shutterstock"
#define FILE_SOURCE_MOBILE @"MOBILE"

#define FILE_TYPE_ALL @"ALL"
#define FILE_TYPE_IMAGES @"IMAGES"
#define FILE_TYPE_DOCUMENTS @"DOCUMENTS"

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
