//
//  CPSVideoListResourceInteractor.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/12.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSVideoListResourceInteractor.h"

#import "CPSAdditionalResourceAssetItem.h"

@implementation CPSVideoListResourceInteractor

- (void)playVideoForItem:(CPSAdditionalResourceAssetItem *)item
{
    [super playVideoForItem:item];
    if (item.additionalResourceSections.count > 0)
    {
        [self.presenter setItemResourceButtonVisible:YES];
    }
}

- (void)itemSelectedAtIndex:(NSUInteger)index
{
    self.selectedIndex = index;
    [super itemSelectedAtIndex:index];
}

- (void)requestResourceForSelectedVideoItem
{
    CPSAdditionalResourceAssetItem *selectedItem = self.videoItems[self.selectedIndex];
    
    [self.wireframe showVideoItemAdditionalResources:selectedItem.additionalResourceSections];
    [self.presenter setItemResourceButtonVisible:NO];
}

- (void)resourceWasShown
{
    // When we show a resource, we should show the additional resource button again
    CPSAdditionalResourceAssetItem *item = self.videoItems[self.selectedIndex];
    if (item.additionalResourceSections.count > 0)
    {
        [self.presenter setItemResourceButtonVisible:YES];
    }
}

@end
