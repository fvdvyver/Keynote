//
//  CPSResourceDirectoryDataProviderAdapter.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/13.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSResourceDirectoryListDataProvider.h"
#import "MCCollectionViewSectionDataProvider.h"
#import "MCCollectionViewCellPresenter.h"

#import "CPSResourceItemView.h"

@interface CPSResourceDirectoryDataProviderAdapter : NSObject <MCCollectionViewSectionDataProvider, MCCollectionViewCellPresenter>

+ (instancetype)adapterWithResourceProvider:(CPSResourceDirectoryListDataProvider *)provider;

- (void)configureCell:(id<CPSResourceItemView>)cell
              forItem:(id)item
          atIndexPath:(NSIndexPath *)indexPath
     inCollectionView:(UICollectionView *)collectionView;

@end
