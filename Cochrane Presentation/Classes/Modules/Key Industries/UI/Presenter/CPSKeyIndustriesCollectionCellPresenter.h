//
//  CPSKeyIndustriesCollectionCellPresenter.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/28.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSKeyIndustriesViewInterface.h"
#import "MCCollectionViewCellPresenter.h"

@class CPSKeyIndustriesCollectionViewCell;

@interface CPSKeyIndustriesCollectionCellPresenter : NSObject <MCCollectionViewCellPresenter>

@property (nonatomic, strong) id<CPSKeyIndustriesItemDataProvider> dataProvider;
@property (nonatomic, assign) BOOL hidesTextView;

- (void)configureCell:(CPSKeyIndustriesCollectionViewCell *)cell
              forItem:(id)item
          atIndexPath:(NSIndexPath *)indexPath
     inCollectionView:(UICollectionView *)collectionView;

@end
