//
//  MyLibraryFoldersService.m
//  CTCTContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import "MyLibraryFoldersService.h"

@implementation MyLibraryFoldersService

#pragma mark - library summary information

+ (HttpResponse *) getMyLibrarySummaryInformationWithAccessToken:(NSString*)accessToken
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"library_folders_info"];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@",accessToken , apiKey];

    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    if (response.statusCode == 200)
    {
        LibrarySummary *summary = [LibrarySummary librarySummaryWithDictionary:response.data];
        [response replaceDataWithNewData:summary];
    }
    return response;
}

#pragma mark - folder collection 

+ (HttpResponse *)getFoldersWithAccessToken:(NSString*)accessToken SortedBy:(NSString *)sortParam withALimitOf:(int)limit
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"library_folders_collection"];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
     NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@",accessToken , apiKey];
    
    if(sortParam && sortParam.length > 0)
    {
       httpQuery = [NSString stringWithFormat:@"%@&sort_by=%@", httpQuery, sortParam]; 
    }
    
    if(limit > 0)
    {
        httpQuery = [NSString stringWithFormat:@"%@&limit=%d", httpQuery, limit];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    if (response.statusCode == 200)
    {
        NSMutableArray *foldersArray = [[NSMutableArray alloc] init];
        NSArray *resultArray = [response.data objectForKey:@"results"];
        
        for (NSDictionary *folderDict in resultArray)
        {
            LibraryFolder *folder = [LibraryFolder folderWithDictionary:folderDict];
            [foldersArray addObject:folder];
        }
        NSDictionary *meta = [response.data objectForKey:@"meta"];
        ResultSet *resultSet = [[ResultSet alloc] initResultSetWithResults:[foldersArray copy] andMeta:meta];
        
        [response replaceDataWithNewData:resultSet];
    }
    return response;
}

+ (HttpResponse *)addFolderWithAccessToken:(NSString*)accessToken andFolder:(LibraryFolder *)folder
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"library_folders_collection"];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@",accessToken , apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    NSString *folderJSON = [folder JSON];
    
    HttpResponse *response = [HttpRequest postWithUrl:url andHeaders:nil andStringData:folderJSON];
    
    if (response.statusCode == 201)
    {
        LibraryFolder *folder = [LibraryFolder folderWithDictionary:response.data];
        [response replaceDataWithNewData:folder];
    }
    return response;
}

#pragma mark - individual folder

+ (HttpResponse *)getFolderWithAccessToken:(NSString*)accessToken withId:(NSString *)folderId
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"library_folders_individual"];
    endpoint = [NSString stringWithFormat:endpoint, folderId];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@",accessToken , apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    if (response.statusCode == 200)
    {
        LibraryFolder *folder = [LibraryFolder folderWithDictionary:response.data];
        [response replaceDataWithNewData:folder];
    }
    return response;
}

+ (HttpResponse *)updateFolderWithAccessToken:(NSString*)accessToken withId:(NSString *)folderId withUpdateFolder:(LibraryFolder *)folder includePayload:(BOOL)payload
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"library_folders_individual"];
    endpoint = [NSString stringWithFormat:endpoint, folderId];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@",accessToken , apiKey];
    
    httpQuery = (payload) ? [NSString stringWithFormat:@"%@&include_payload=TRUE", httpQuery] : [NSString stringWithFormat:@"%@&include_payload=FALSE", httpQuery];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    NSString *folderJSON = [folder JSON];
    
    HttpResponse *response = [HttpRequest putWithUrl:url andHeaders:nil andStringData:folderJSON];
    
    if (response.statusCode == 200)
    {
        LibraryFolder *folder = [LibraryFolder folderWithDictionary:response.data];
        [response replaceDataWithNewData:folder];
    }
    return response;
}

+ (BOOL)deleteFolderWithAccessToken:(NSString *)accessToken andWithId:(NSString *)folderId errors:(NSArray**)errors
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"library_folders_individual"];
    endpoint = [NSString stringWithFormat:endpoint, folderId];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@",accessToken , apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest deleteWithUrl:url andHeaders:nil];
    
    *errors = response.errors;
    
    return (response.statusCode == 204);
}

#pragma mark - folder trash 

+ (HttpResponse *)getTrashFoldersWithAccessToken:(NSString*)accessToken withType:(NSString *)type sortedBy:(NSString *)sortby withALimitOf:(int)limit
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"library_folders_trash"];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@",accessToken , apiKey];
    
    if(type && type.length > 0)
    {
        httpQuery = [NSString stringWithFormat:@"%@&type=%@", httpQuery, type];
    }
    
    if(sortby && sortby.length > 0)
    {
        httpQuery = [NSString stringWithFormat:@"%@&sort_by=%@", httpQuery, sortby];
    }
    
    if(limit > 0)
    {
        httpQuery = [NSString stringWithFormat:@"%@&limit=%d", httpQuery, limit];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest getWithUrl:url andHeaders:nil];
    
    if (response.statusCode == 200)
    {
        NSMutableArray *trashArray = [[NSMutableArray alloc] init];
        NSArray *resultArray = [response.data objectForKey:@"results"];
        
        for (NSDictionary *trashDict in resultArray)
        {
            LibraryFile *trash = [LibraryFile fileWithDictionary:trashDict];
            [trashArray addObject:trash];
        }
        NSDictionary *meta = [response.data objectForKey:@"meta"];
        ResultSet *resultSet = [[ResultSet alloc] initResultSetWithResults:[trashArray copy] andMeta:meta];
        
        [response replaceDataWithNewData:resultSet];
    }
    return response;
}

+ (BOOL)deleteTrashFoldersWithAccessToken:(NSString *)accessToken errors:(NSArray**)errors
{
    NSString *baseURL = [Config valueForType:@"endpoints" key:@"base_url"];
    NSString *endpoint = [Config valueForType:@"endpoints" key:@"library_folders_trash"];
    NSString *apiKey = [Config valueForType:@"config" key:@"api_key"];
    NSString *httpQuery = [NSString stringWithFormat:@"access_token=%@&api_key=%@",accessToken , apiKey];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?%@", baseURL, endpoint, httpQuery];
    
    HttpResponse *response = [HttpRequest deleteWithUrl:url andHeaders:nil];
    
    *errors = response.errors;
    
    return (response.statusCode == 204);
}
@end
