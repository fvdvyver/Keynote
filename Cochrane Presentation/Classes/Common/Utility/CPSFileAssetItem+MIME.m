//
//  CPSFileAssetItem+MIME.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/13.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSFileAssetItem+MIME.h"

#import <objc/runtime.h>

@implementation CPSFileAssetItem (MIME)

static void * const kFileTypeAssociationKey = (void *)&kFileTypeAssociationKey;

- (void)setFileType:(CPSFileAssetType)fileType
{
    objc_setAssociatedObject(self, kFileTypeAssociationKey, @(fileType), OBJC_ASSOCIATION_RETAIN);
}

- (CPSFileAssetType)fileType
{
    return [objc_getAssociatedObject(self, kFileTypeAssociationKey) integerValue];
}

@end
