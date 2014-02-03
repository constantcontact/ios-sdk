//
//  MyLibraryFilesService.m
//  CTCTContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "MyLibraryFilesService.h"

@implementation MyLibraryFilesService

#pragma mark - file collections

+ (HttpResponse *)getFileCollectionWithAccessToken:(NSString*)accessToken type:(NSString *)type source:(NSString *)source withALimitOf:(int)limit
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"library_files"];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@",accessToken , apiKey];
    
    if(type && type.length > 0)
    {
        httpQuery = [NSString stringWithFormat:@"%@&type=%@",httpQuery , type];
    }
    
    if(source && source.length > 0)
    {
        httpQuery = [NSString stringWithFormat:@"%@&source=%@",httpQuery , source];
    }
    
    if(limit > 0)
    {
        httpQuery = [NSString stringWithFormat:@"%@&limit=%d",httpQuery , limit];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    if (response.statusCode == 200)
    {
        NSMutableArray *fileArray = [[NSMutableArray alloc] init];
        NSArray *resultArray = [response.data objectForKey:@"results"];
        
        for (NSDictionary *fileDict in resultArray)
        {
            LibraryFile *file = [LibraryFile fileWithDictionary:fileDict];
            [fileArray addObject:file];
        }
        NSDictionary *meta = [response.data objectForKey:@"meta"];
        ResultSet *resultSet = [[ResultSet alloc] initResultSetWithResults:[fileArray copy] andMeta:meta];
        
        [response replaceDataWithNewData:resultSet];
    }
    return response;
}

#pragma mark - file collections by folder

+ (HttpResponse *)getFileCollectionWithAccessToken:(NSString*)accessToken folderId:(NSString *)folderId withaAimitOf:(int)limit
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"library_files_by_folder"];
    endpoint = [NSString stringWithFormat:endpoint, folderId];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@",accessToken , apiKey];
    
    if(limit > 0)
    {
        httpQuery = [NSString stringWithFormat:@"%@&limit=%d",httpQuery , limit];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    if (response.statusCode == 200)
    {
        NSMutableArray *fileArray = [[NSMutableArray alloc] init];
        NSArray *resultArray = [response.data objectForKey:@"results"];
        
        for (NSDictionary *fileDict in resultArray)
        {
            LibraryFile *file = [LibraryFile fileWithDictionary:fileDict];
            [fileArray addObject:file];
        }
        NSDictionary *meta = [response.data objectForKey:@"meta"];
        ResultSet *resultSet = [[ResultSet alloc] initResultSetWithResults:[fileArray copy] andMeta:meta];
        
        [response replaceDataWithNewData:resultSet];
    }
    return response;
}

#pragma mark - individual file
+ (HttpResponse *)getFileWithAccessToken:(NSString*)accessToken andFileId:(NSString *)fileId 
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"library_files_individual"];
    endpoint = [NSString stringWithFormat:endpoint, fileId];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@",accessToken , apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    if (response.statusCode == 200)
    {
        LibraryFile *file = [LibraryFile fileWithDictionary:response.data];
        [response replaceDataWithNewData:file];
    }
    return response;
}

+ (HttpResponse *)updateFileWithAccessToken:(NSString*)accessToken fileId:(NSString *)fileId includePayload:(BOOL)includePayload andFile:(LibraryFile *)file
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"library_files_individual"];
    endpoint = [NSString stringWithFormat:endpoint, fileId];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@",accessToken , apiKey];
    
    httpQuery = (includePayload) ? [NSString stringWithFormat:@"%@&include_payload=TRUE", httpQuery] : [NSString stringWithFormat:@"%@&include_payload=FALSE", httpQuery];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    NSString *fileJSON = [file JSON];
    
    HttpResponse *response = [HttpRequest putWithUrl:url andHeaders:nil andStringData:fileJSON];
    
    if (response.statusCode == 200)
    {
        LibraryFile *file = [LibraryFile fileWithDictionary:response.data];
        [response replaceDataWithNewData:file];
    }
    return response;
}

+ (BOOL)deleteFileWithAccessToken:(NSString*)accessToken andFileId:(NSString *)fileId errors:(NSArray**)errors;
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"library_files_individual"];
    endpoint = [NSString stringWithFormat:endpoint, fileId];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@",accessToken , apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest deleteWithUrl:url andHeaders:nil];
    
    *errors = response.errors;
    
    return (response.statusCode == 204);
}

#pragma mark - file with multipart

+ (HttpResponse *)addFileMultipartWithToken:(NSString *)accessToken withFile:(NSString *)file toFolder:(NSString *)folderId withDescription:(NSString *)description fromSource:(NSString *)source errors:(NSArray**)errors;
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"library_files"];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@", accessToken, apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    NSString *fileName = [file lastPathComponent];
    
    NSData *content = [[NSFileManager defaultManager] contentsAtPath:file];
    
    HttpResponse *response = [HttpRequest httpMultipartRequestWithUrl:url file:fileName folderId:folderId description:description source:source data:content];
    
    return response;
}

#pragma mark - file upload status
+ (HttpResponse *)getUploadStatusWithAccessToken:(NSString*)accessToken forFilesInArray:(NSArray *)fileIds;
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"library_files_upload_status"];
    NSString * fileArray = [fileIds componentsJoinedByString:@","];
    endpoint = [NSString stringWithFormat:endpoint, fileArray];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@",accessToken , apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    if (response.statusCode == 200)
    {
        NSMutableArray *uploadArray = [[NSMutableArray alloc] init];
       
        for (NSDictionary *uploadDict in response.data)
        {
            FileUploadStatus *upload = [FileUploadStatus fileUploadStatusWithDictionary:uploadDict];
            [uploadArray addObject:upload];
        }
        [response replaceDataWithNewData:uploadArray];
    }
    return response;
}

#pragma mark - move file

+ (HttpResponse *)moveFilesWithAccessToken:(NSString*)accessToken toFolderWithId:(NSString *)folderId withMoveFilesArray:(NSArray *)arr
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"library_files_move"];
    endpoint = [NSString stringWithFormat:endpoint, folderId];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@",accessToken , apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    NSString * fileArray = [self toJson:arr] ;
    
    HttpResponse *response = [HttpRequest putWithUrl:url andHeaders:nil andStringData:fileArray];
    
    if (response.statusCode == 200)
    {
        NSMutableArray *movementArray = [[NSMutableArray alloc] init];
        NSArray *resultArray = response.data;
        
        for (NSDictionary *movedDict in resultArray)
        {
            FileMoved *movedFile = [FileMoved fileMovementWithDictionary:movedDict];
            [movementArray addObject:movedFile];
        }
        [response replaceDataWithNewData:movementArray];
    }
    return response;
}

+ (NSString *)toJson:(NSArray *)arr
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *jsonString = @"";
    
    if (!jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return  jsonString;
}
@end
