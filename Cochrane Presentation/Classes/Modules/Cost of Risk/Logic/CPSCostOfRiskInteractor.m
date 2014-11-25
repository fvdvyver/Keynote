//
//  CPSCostOfRiskInteractor.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/24.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSCostOfRiskInteractor.h"

#import "CPSBaseWireframe.h"

#import "CPSCostOfRiskItem.h"

@interface CPSCostOfRiskInteractor ()

@property (nonatomic, assign) NSUInteger currentItemIndex;

- (void)playVideoForItem:(CPSCostOfRiskItem *)item;

@end

@implementation CPSCostOfRiskInteractor

@synthesize wireframe = _wireframe;
@synthesize presenter = _presenter;

- (void)resetState
{
    self.currentItemIndex = 0;
    [self.presenter resetState];
}

- (void)advanceCurrentItem
{
    if (self.currentItemIndex < self.presentationItems.count)
    {
        CPSCostOfRiskItem *item = self.presentationItems[self.currentItemIndex++];
        [self.presenter addItem:item.titleText];
        [self playVideoForItem:item];
    }
    else
    {
        [self.wireframe advanceCurrentContentProvider];
    }
}

- (void)itemSelectedAtIndex:(NSUInteger)index
{
    CPSCostOfRiskItem *item = self.presentationItems[self.currentItemIndex];
    [self playVideoForItem:item];
}

- (void)playVideoForItem:(CPSCostOfRiskItem *)item
{
    NSString *resourceName = [item.videoFile stringByDeletingPathExtension];
    NSString *pathExtension = [item.videoFile pathExtension];
    NSString *path = [[NSBundle mainBundle] pathForResource:resourceName ofType:pathExtension];
    
//    [self.presenter playVideoAtPath:path];
}

@end
