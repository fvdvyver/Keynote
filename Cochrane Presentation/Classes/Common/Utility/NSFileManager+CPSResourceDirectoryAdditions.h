//
//  NSFileManager+CPSResourceDirectoryAdditions.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/14.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CPSFileAssetItem;
@class CPSResourceDirectory;

@interface NSFileManager (CPSResourceDirectoryAdditions)

/**
 *  Returns a list of all the files in the given directory that are not folders
 */
- (NSArray *)filePathsOfNonDirectoriesAtPath:(NSString *)path;

/**
 *  Returns a new CPSAssetItem configured with the specified path, and with the fileType (from CPSFileAssetItem+MIME.h) specified
 */
- (CPSFileAssetItem *)assetWithPath:(NSString *)path;
/**
 *  Loads up a CPSResource directory using the contents of the directory at the specified path
 */
- (CPSResourceDirectory *)loadResourcesAtDirectory:(NSString *)path;
/**
 *  Returns a list of CPSResourceDirectory, one for each folder in the given directory
 */
- (NSArray *)loadSectionedResourcesAtDirectory:(NSString *)path;

@end
