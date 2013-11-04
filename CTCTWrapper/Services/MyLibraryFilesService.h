//
//  MyLibraryFilesService.h
//  CTCTContact
//
//  Copyright (c) 2013 Constant Contact. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileUploadStatus.h"
#import "HttpRequest.h"
#import "LibraryFile.h"
#import "FileMoved.h"
#import "ResultSet.h"
#import "Config.h"

@interface MyLibraryFilesService : NSObject

#pragma mark - file collection

/**
 * Returns a collection of MyLibrary files.
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *type - (optional) Specifies the type of files to retrieve, ALL, IMAGES, or DOCUMENTS. Default All.
 * @param NSString *source - (optional) Specifies to retrieve files from a particular source: ALL , MyComputer, StockImage, Facebook, Instagram, Shutterstock, Mobile. Default All.
 * @param int limit - (optional) the number of elements to be returned, default 50;
 *
 * @return HttpResponse * - response containing data and errors (if there are some)
 */
+ (HttpResponse *)getFileCollectionWithAccessToken:(NSString*)accessToken type:(NSString *)type source:(NSString *)source withALimitOf:(int)limit;

#pragma mark - file collection by folder

/**
 * Retrieve MyLibrary files from a specific folder.
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *folderId - the id of the folder that containes the desired files.
 * @param int limit - (optional) the number of elements to be returned, default 50;
 *
 * @return HttpResponse * - response containing data and errors (if there are some)
 */
+ (HttpResponse *)getFileCollectionWithAccessToken:(NSString*)accessToken folderId:(NSString *)folderId withaAimitOf:(int)limit;

#pragma mark - individual file

/**
 * Retrieve information for a specific MyLibrary file
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *fileId - the id of the desired file.
 *
 * @return HttpResponse * - response containing data and errors (if there are some)
 */
+ (HttpResponse *)getFileWithAccessToken:(NSString*)accessToken andFileId:(NSString *)fileId;

/**
 * Update information for a specific MyLibrary file
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *fileId - an individual MyLibrary file that you want to update
 * @param File *file - the file that is about to be updated;
 * @param BOOL includePayload - (optional) Determines if updated files JSON payload is returned : YES , NO. Default YES.
 *
 * @return HttpResponse * - response containing data and errors (if there are some)
 */
+ (HttpResponse *)updateFileWithAccessToken:(NSString*)accessToken fileId:(NSString *)fileId includePayload:(BOOL)includePayload andFile:(LibraryFile *)file;

/**
 * DELETE an individual MyLibrary file.
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *fileId - an individual MyLibrary file that you want to delete
 *
 * @return boolean - if the deletion action was succcesful or not
 */
+ (BOOL)deleteFileWithAccessToken:(NSString*)accessToken andFileId:(NSString *)fileId errors:(NSArray**)errors;

#pragma mark - add multipart file
/**
 * Function is used to add a file to a folder.
 *
 *  @param NSString *accessToken - Constant Contact OAuth2 access token
 *  @param NSString *file - the file path for the file sent to the server.
 *  @param NSString *folderId - the folder destination for the file sent to the server.
 *  @param NSString *description - user description for the file sent to the server.
 *  @param NSString *fromSource - the source of the original file: MyComputer, StockImage, Facebook, Instagram, Shutterstock, Mobile
 *  @param NSString* data - the data from the selected file in string format.
 *
 *  @return BOOL - value that shows if upload was succesfull or not;
 */
+ (BOOL)addFileMultipartWithToken:(NSString *)accessToken withFile:(NSString *)file toFolder:(NSString *)folderId withDescription:(NSString *)description fromSource:(NSString *)source errors:(NSArray**)errors;

#pragma mark - file upload status

/**
 *  Retrieve the status of one or more files uploaded to MyLibrary.
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSArray *fileIds - a array containing file id's, in string format;
 *
 * @return HttpResponse * - response containing data and errors (if there are some)
 */
+ (HttpResponse *)getUploadStatusWithAccessToken:(NSString*)accessToken forFilesInArray:(NSArray *)fileIds;

#pragma mark - move a file

/**
 * Moves files in the array to the desiganted folder.
 *
 * @param NSString *accessToken - Constant Contact OAuth2 access token
 * @param NSString *folderId - an individual MyLibrary folder that you want to move the files to
 * @param NSArray *arr - a array containing file id's, in string format;
 *
 * @return HttpResponse * - response containing data and errors (if there are some)
 */
+ (HttpResponse *)moveFilesWithAccessToken:(NSString*)accessToken toFolderWithId:(NSString *)folderId withMoveFilesArray:(NSArray *)arr;

@end
