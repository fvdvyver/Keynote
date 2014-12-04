//
//  CPSProductItemPresenter.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/01.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSProductRangeListViewInterface.h"

@class CPSProductAssetItem;

@interface CPSProductItemPresenter : NSObject <CPSProductItemPresenter>

+ (instancetype)presenterWithImageMaps:(NSDictionary *)imageMaps;

- (void)configureVideoView:(id<CPSProductItemVideoView>)view withItem:(CPSProductAssetItem *)item;

@end
