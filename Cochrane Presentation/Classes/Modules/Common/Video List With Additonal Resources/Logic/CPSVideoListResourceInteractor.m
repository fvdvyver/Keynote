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

- (void)playVideoForItem:(CPSAssetItem *)item
{
    [self.presenter setItemResourceButtonVisible:YES];
    [super playVideoForItem:item];
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

@end
