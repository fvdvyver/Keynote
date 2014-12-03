//
//  CPSProductItemCollectionCellPresenter.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/01.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSProductRangeListViewInterface.h"
#import "MCCollectionViewCellPresenter.h"

@class CPSProductItemCollectionViewCell;

@interface CPSProductItemCollectionCellPresenter : NSObject <MCCollectionViewCellPresenter>

@property (nonatomic, weak) id<CPSProductItemPresenter> itemPresenter;
@property (nonatomic, assign) BOOL hidesTextView;

- (void)configureCell:(CPSProductItemCollectionViewCell *)cell
              forItem:(id)item
          atIndexPath:(NSIndexPath *)indexPath
     inCollectionView:(UICollectionView *)collectionView;

@end
