//
//  CPSCostOfRiskInteractor.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/24.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSCostOfRiskInteractor.h"

#import "CPSBaseWireframe.h"
#import "CPSVideoListItem.h"

@interface CPSCostOfRiskInteractor ()

@property (nonatomic, assign) NSUInteger currentItemIndex;

@end

@implementation CPSCostOfRiskInteractor

- (void)resetState
{
    self.currentItemIndex = 0;
    [self.presenter resetState];
}

- (void)advanceCurrentItem
{
    if (self.currentItemIndex < self.videoItems.count)
    {
        CPSVideoListItem *item = self.videoItems[self.currentItemIndex++];
        [self.presenter addItem:item.titleText];
        [self playVideoForItem:item];
    }
    else
    {
        [self.wireframe advanceCurrentContentProvider];
    }
}

@end
