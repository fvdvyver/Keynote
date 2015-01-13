//
//  CPSFileAssetItem+MIME.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/13.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSFileAssetItem.h"

typedef NS_ENUM(NSInteger, CPSFileAssetType)
{
    CPSFileAssetTypeImage,
    CPSFileAssetTypeVideo,
    CPSFileAssetTypeUnknown
};

@interface CPSFileAssetItem (MIME)

@property (nonatomic, assign) CPSFileAssetType fileType;

@end
