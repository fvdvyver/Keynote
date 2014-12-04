//
//  CPSProductRangeListPresenter.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/01.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSProductRangeListPresenter.h"

#import "CPSProductAssetItem.h"
#import "CPSProductItemPresenter.h"

@interface CPSProductRangeListPresenter ()

@end

@implementation CPSProductRangeListPresenter

- (void)updateView
{
    // Only request data after a small delay to ensure the old resources are deallocated before any new ones are created
    [(id)self.interactor performSelector:@selector(requestData) withObject:nil afterDelay:0.01];
}

- (void)setProductItems:(NSArray *)productItems withImageMapDictionary:(NSDictionary *)imageMaps
{   
    [self.userInterface setItemPresenter:[CPSProductItemPresenter presenterWithImageMaps:imageMaps]];
    [self.userInterface setProductItems:productItems];
}

- (void)item:(CPSProductAssetItem *)item selectedAtIndex:(NSInteger)index
{
    if (item.actionType == CPSProductAssetActionTypeShowDetail)
    {
        [self.wireframe showProductWithTitle:item.title videoName:item.secondaryFilename];
    }
    else if (item.actionType == CPSProductAssetActionTypeNavigate)
    {
        [self.wireframe setContentControllerProviderWithIdentifer:item.secondaryFilename];
    }
    else
    {
        NSLog(@"WARNING: action type (%li) for product item %@ not supported", (long)item.actionType, item.title);
    }
}

@end
