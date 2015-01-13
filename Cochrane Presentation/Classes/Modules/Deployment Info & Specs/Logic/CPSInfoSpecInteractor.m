//
//  CPSInfoSpecInteractor.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/05.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSInfoSpecInteractor.h"

#import "CPSBaseWireframe.h"
#import "CPSSpecificationInfoAssetItem.h"

#import "CPSCompatUtils.h"

#define CPSPropertyString(x) NSStringFromSelector(@selector(x))

@interface CPSInfoSpecInteractor ()

- (void)showOutputForItem:(CPSSpecificationInfoAssetItem *)item;

@end

@implementation CPSInfoSpecInteractor

- (void)requestData
{
    [self.presenter setVideoTitles:[self.videoItems valueForKey:CPSPropertyString(title)]];
}

- (void)itemSelected:(CPSSpecificationInfoAssetItem *)item
{
    if (item.navigationIdentifier.length > 0)
    {
        [self.wireframe setContentControllerProviderWithIdentifer:item.navigationIdentifier];
    }
    else
    {
        [super itemSelected:item];
        [self showOutputForItem:item];
    }
}

- (void)showOutputForItem:(CPSSpecificationInfoAssetItem *)item
{
    [self.presenter showTitleText:item.title];
    [self.presenter showInfoStrings:item.details];
    [self.presenter showModelWithVideoName:item.modelVideoName];
    
    if ([CPSCompatUtils InfoSpecViewShouldPlaySecurityLevelVideo])
    {
        [self.presenter showSecurityLevelVideoWithName:item.securityLevelVideoName];
    }
    else
    {
        [self.presenter showSecurityLevelImageWithName:item.securityLevelImageName];
    }
}

@end
