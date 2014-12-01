//
//  CPSProductAssetItem.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/01.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSProductAssetItem.h"

@implementation CPSProductAssetItem

- (void)setActionTypeFromString:(NSString *)actionType
{
    if ([actionType isEqualToString:@"show detail"])
    {
        self.actionType = CPSProductAssetActionTypeShowDetail;
    }
    else if ([actionType isEqualToString:@"video"])
    {
        self.actionType = CPSProductAssetActionTypeNavigate;
    }
}

@end
