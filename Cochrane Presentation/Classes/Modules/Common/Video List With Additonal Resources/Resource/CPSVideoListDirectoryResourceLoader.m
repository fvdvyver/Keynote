//
//  CPSVideoListDirectoryResourceLoader.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/12.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSVideoListDirectoryResourceLoader.h"

#import "CPSFileAssetItem.h"
#import "CPSFileAssetItem+MIME.h"

@implementation CPSVideoListDirectoryResourceLoader

- (id)assetFromPath:(NSString *)path
{
    CPSFileAssetItem *asset = [super assetFromPath:path];
    NSString *extension = [asset.path pathExtension];
    NSNumber *fileTypeValue = @{
                                 @"png"  : @(CPSFileAssetTypeImage),
                                 @"jpg"  : @(CPSFileAssetTypeImage),
                                 @"jpeg" : @(CPSFileAssetTypeImage),
                                 @"mp4"  : @(CPSFileAssetTypeVideo)
                                }[extension];
    
    asset.fileType = (fileTypeValue == nil) ? CPSFileAssetTypeUnknown : [fileTypeValue integerValue];
    
    return asset;
}

@end
