//
//  CPSKeyIndustriesGridPresenter.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/27.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSKeyIndustriesGridPresenter.h"

#import "CPSKeyIndustriesItemDatasource.h"
#import "CPSAssetItem.h"

@interface CPSKeyIndustriesGridPresenter ()

@property (nonatomic, strong) CPSKeyIndustriesItemDatasource *provider;

@end

@implementation CPSKeyIndustriesGridPresenter

- (void)updateView
{
    [self.interactor requestData];
}

- (void)setIndustryItems:(NSArray *)industryItems
{
    CPSKeyIndustriesItemDatasource *provider = [CPSKeyIndustriesItemDatasource new];
    provider.items = industryItems;
    
    self.provider = provider;
    [self.userInterface setItemDataProvider:self.provider];
}

- (void)item:(CPSAssetItem *)item selectedAtIndex:(NSInteger)index
{
    [self.wireframe showIndustryWithTitle:item.title imageName:item.primaryFilename];
}

- (void)productsButtonTapped
{
    [self.wireframe navigateToProductRange];
}

@end
