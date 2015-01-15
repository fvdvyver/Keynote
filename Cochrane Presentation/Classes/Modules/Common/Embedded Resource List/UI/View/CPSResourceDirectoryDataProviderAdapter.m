//
//  CPSResourceDirectoryDataProviderAdapter.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/13.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSResourceDirectoryDataProviderAdapter.h"

@interface CPSResourceDirectoryDataProviderAdapter ()

@property (nonatomic, weak) CPSResourceDirectoryListDataProvider *provider;

@end

@implementation CPSResourceDirectoryDataProviderAdapter

+ (instancetype)adapterWithResourceProvider:(CPSResourceDirectoryListDataProvider *)provider
{
    CPSResourceDirectoryDataProviderAdapter *adapter = [[self class] new];
    adapter.provider = provider;
    
    return adapter;
}

- (NSInteger)numberOfSections
{
    return [self.provider numberOfSections];
}

- (NSInteger)numberOfItemsInSection:(NSInteger)sectionIdx
{
    return [self.provider numberOfItemsInSection:sectionIdx];
}

- (id)sectionDataForIndexPath:(NSIndexPath *)indexPath
{
    return [self.provider sectionDataForSectionAtIndex:indexPath.section];
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.provider itemAtIndexPath:indexPath];
}

- (void)configureCell:(id<CPSResourceItemView>)cell
              forItem:(id)item
          atIndexPath:(NSIndexPath *)indexPath
     inCollectionView:(UICollectionView *)collectionView
{
    CPSFileAssetType type;
    NSString *path = [self.provider assetPathForItem:item outType:&type];
    
    [cell setTitle:[self.provider titleForItem:item]];
    [cell setAssetPath:path type:type];
    [cell setFileTypeImage:[self.provider fileTypeImageForItem:item]];
}

- (void)configureSupplementaryView:(id<CPSResourceListHeaderView>)view
                          withData:(id)sectionData
                       atIndexPath:(NSIndexPath *)indexPath
                  inCollectionView:(UICollectionView *)collectionView
{
    [view setTitle:[self.provider titleForSectionData:sectionData]];
}

@end
