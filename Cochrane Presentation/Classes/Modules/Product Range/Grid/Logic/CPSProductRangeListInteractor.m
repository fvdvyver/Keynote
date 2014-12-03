//
//  CPSProductRangeListInteractor.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/01.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSProductRangeListInteractor.h"

#import "CPSProductAssetItem.h"

@implementation CPSProductRangeListInteractor

@synthesize wireframe = _wireframe;

- (void)requestData
{
    [self.presenter setProductItems:self.productItems];
}

@end
