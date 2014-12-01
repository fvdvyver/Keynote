//
//  CPSProductItemCollectionCellPresenter.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/01.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSProductItemCollectionCellPresenter.h"

#import "CPSProductItemCollectionViewCell.h"

@implementation CPSProductItemCollectionCellPresenter

- (void)configureCell:(CPSProductItemCollectionViewCell *)cell
              forItem:(id)item
          atIndexPath:(NSIndexPath *)indexPath
     inCollectionView:(UICollectionView *)collectionView
{
    [self.itemPresenter configureVideoView:cell withItem:item];
}

@end
