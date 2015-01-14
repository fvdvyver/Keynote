//
//  CPSResourceDirectory+FileTypeAdditions.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/14.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSResourceDirectory+FileTypeAdditions.h"

#import "CPSFileAssetItem.h"

@implementation CPSResourceDirectory (FileTypeAdditions)

- (NSArray *)filePathsForAllImages
{
    NSMutableArray *paths = [NSMutableArray arrayWithCapacity:self.contentFiles.count];
    for (CPSFileAssetItem *asset in self.contentFiles)
    {
        if (asset.fileType == CPSFileAssetTypeImage)
        {
            [paths addObject:asset.path];
        }
    }
    return [NSArray arrayWithArray:paths];
}

@end
