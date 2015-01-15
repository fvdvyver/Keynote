//
//  NSFileManager+CPSResourceDirectoryAdditions.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/14.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "NSFileManager+CPSResourceDirectoryAdditions.h"

#import "CPSFileAssetItem.h"
#import "CPSFileAssetItem+MIME.h"
#import "CPSResourceDirectory+FileTypeAdditions.h"

@implementation NSFileManager (CPSResourceDirectoryAdditions)

- (CPSFileAssetItem *)assetWithPath:(NSString *)path
{
    CPSFileAssetItem *asset = [CPSFileAssetItem itemWithPath:path];
    NSString *extension = [asset.path pathExtension];
    NSNumber *fileTypeValue = @{
                                @"png"  : @(CPSFileAssetTypeImage),
                                @"jpg"  : @(CPSFileAssetTypeImage),
                                @"jpeg" : @(CPSFileAssetTypeImage),
                                @"mp4"  : @(CPSFileAssetTypeVideo),
                                @"pdf"  : @(CPSFileAssetTypePDF)
                                }[extension];
    
    asset.fileType = (fileTypeValue == nil) ? CPSFileAssetTypeUnknown : [fileTypeValue integerValue];
    
    return asset;
}

- (CPSResourceDirectory *)loadResourcesAtDirectory:(NSString *)path
{
    BOOL isDir = NO;
    CPSResourceDirectory *directory;
    
    if ([self fileExistsAtPath:path isDirectory:&isDir] && isDir)
    {
        NSError *error = nil;
        NSArray *directoryContents = [self contentsOfDirectoryAtPath:path error:&error];
        
        NSAssert(error == nil, @"An error occurred getting the contents of directory %@: %@", path, error.localizedDescription);
        
        NSMutableArray *resourceArray = [NSMutableArray arrayWithCapacity:directoryContents.count];
        for (NSString *resourceName in directoryContents)
        {
            NSString *resourcePath = [path stringByAppendingPathComponent:resourceName];
            [resourceArray addObject:[self assetWithPath:resourcePath]];
        }
        
        directory = [CPSResourceDirectory new];
        directory.directoryName = [path lastPathComponent];
        directory.directoryPath = path;
        directory.contentFiles = [NSArray arrayWithArray:resourceArray];
    }
    
    return directory;
}

- (NSArray *)loadSectionedResourcesAtDirectory:(NSString *)path
{
    BOOL isDir = NO;
    NSMutableArray *resourceDirectoryArray;
    
    if ([self fileExistsAtPath:path isDirectory:&isDir] && isDir)
    {
        NSError *error = nil;
        NSArray *directoryContents = [self contentsOfDirectoryAtPath:path error:&error];
        
        NSAssert(error == nil, @"An error occurred getting the contents of directory %@: %@", path, error.localizedDescription);
        
        resourceDirectoryArray = [NSMutableArray arrayWithCapacity:directoryContents.count];
        for (NSString *directory in directoryContents)
        {
            NSString *directoryPath = [path stringByAppendingPathComponent:directory];
            CPSResourceDirectory *resourceDirectory = [self loadResourcesAtDirectory:directoryPath];
            if (resourceDirectory != nil)
            {
                [resourceDirectoryArray addObject:resourceDirectory];
            }
        }
    }
    else
    {
        NSLog(@"Warning: %@: file does not exist at path %@", NSStringFromClass(self.class), path);
    }
    
    return (resourceDirectoryArray == nil) ? nil : [NSArray arrayWithArray:resourceDirectoryArray];
}

@end
