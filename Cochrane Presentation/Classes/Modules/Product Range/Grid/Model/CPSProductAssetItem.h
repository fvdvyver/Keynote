//
//  CPSProductAssetItem.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/01.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSAssetItem.h"

typedef NS_ENUM(NSInteger, CPSProductAssetActionType)
{
    CPSProductAssetActionTypeShowDetail,
    CPSProductAssetActionTypeNavigate
};

@interface CPSProductAssetItem : CPSAssetItem

@property (nonatomic, assign) BOOL loopsVideo;
@property (nonatomic, assign) CPSProductAssetActionType actionType;

- (void)setActionTypeFromString:(NSString *)actionType; // "show detail" or "navigate"

@end
