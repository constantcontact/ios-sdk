//
//  MyLibraryFoldersService.h
//  CTCTContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LibrarySummary.h"
#import "LibraryFolder.h"
#import "HttpRequest.h"
#import "LibraryFile.h"
#import "ResultSet.h"

#import "Config.h"

@interface MyLibraryFoldersService : NSObject

#pragma mark - library summary information
/**
 * Retrieve MyLibrary usage information
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 *
 * @return HttpResponse * - response containing data and errors (if there are some)
 */
+ (HttpResponse *) getMyLibrarySummaryInformationWithAccessToken:(NSString*)accessToken;

#pragma mark - folder collection 
/**
 * Retrieve all existing MyLibrary folders
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *sortParam - (optional) Specifies how the list of folders is sorted, alid sort options are: CREATED_DATE, CREATED_DATE, MODIFIED_DATE, MODIFIED_DATE_DESC, NAME, NAME_DESC. Default value is ADDED_DATE_DESC.
 * @param int limit - (optional) the number of elements to be returned, default 50;
 * @return HttpResponse * - response containing data and errors (if there are some)
 */
+ (HttpResponse *)getFoldersWithAccessToken:(NSString *)accessToken SortedBy:(NSString *)sortParam withALimitOf:(int)limit;

/**
 * Creates a MyLibrary folder
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param Folder *folder - the folder that is about to be created;
 *
 * @return HttpResponse * - response containing data and errors (if there are some)
 */
+ (HttpResponse *)addFolderWithAccessToken:(NSString *)accessToken andFolder:(LibraryFolder *)folder;

#pragma mark - individual folder

/**
 * Retrieve an individual MyLibrary folder.
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *folderId - an individual MyLibrary folder that you want to retrieve
 *
 * @return HttpResponse * - response containing data and errors (if there are some)
 */
+ (HttpResponse *)getFolderWithAccessToken:(NSString *)accessToken withId:(NSString *)folderId;

/**
 * Update a existing MyLibrary folders
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *folderId - an individual MyLibrary folder that you want to update
 * @param Folder *folder - the folder that is about to be updated;
 * @param BOOL payload - (optional) Determines if updated folders JSON payload is returned : YES , NO. Default YES.
 *
 * @return HttpResponse * - response containing data and errors (if there are some)
 */
+ (HttpResponse *)updateFolderWithAccessToken:(NSString *)accessToken withId:(NSString *)folderId withUpdateFolder:(LibraryFolder *)folder includePayload:(BOOL)payload;

/**
 * DELETE an individual MyLibrary folder.
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *folderId - an individual MyLibrary folder that you want to delete
 *
 * @return boolean - if the deletion action was succcesful or not
 */
+ (BOOL)deleteFolderWithAccessToken:(NSString *)accessToken andWithId:(NSString *)folderId errors:(NSArray**)errors;

#pragma mark - folder trash

/**
 * Retrieves the files in the Trash folder. 
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *type - (optional) Specifies the type of files to retrieve, ALL, IMAGES, or DOCUMENTS. Default ALL.
 * @param NSString *sortby - (optional) Specifies how the list of folders is sorted, alid sort options are: ADDED_DATE, ADDED_DATE_DESC, MODIFIED_DATE, MODIFIED_DATE_DESC, NAME, NAME_DESC. Default value is ADDED_DATE_DESC.
 * @param int limit - (optional) the number of elements to be returned, default 50;
 *
 * @return HttpResponse * - response containing data and errors (if there are some)
 */
+ (HttpResponse *)getTrashFoldersWithAccessToken:(NSString*)accessToken withType:(NSString *)type sortedBy:(NSString *)sortby withALimitOf:(int)limit;

/**
 * Permanently DELETE the files in the Trash folder.
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 *
 * @return boolean - if the deletion action was succcesful or not
 */
+ (BOOL)deleteTrashFoldersWithAccessToken:(NSString *)accessToken errors:(NSArray**)errors;
@end
