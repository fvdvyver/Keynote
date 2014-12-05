//
//  CPSInfoSpecInteractor.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/05.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSInfoSpecInteractor.h"

#import "CPSSpecificationInfoAssetItem.h"

#define CPSPropertyString(x) NSStringFromSelector(@selector(x))

@implementation CPSInfoSpecInteractor

- (void)requestData
{
    [self.presenter setVideoTitles:[self.videoItems valueForKey:CPSPropertyString(title)]];
}

- (void)itemSelectedAtIndex:(NSUInteger)index
{
    CPSSpecificationInfoAssetItem *item = self.videoItems[index];
    
    [self.presenter showTitleText:item.title];
    [self.presenter showInfoStrings:item.details];
    [self.presenter showModelWithVideoName:item.modelVideoName];
    [self playVideoForItem:item];
}

@end
