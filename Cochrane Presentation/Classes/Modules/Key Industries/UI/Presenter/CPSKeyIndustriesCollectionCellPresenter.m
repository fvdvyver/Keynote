//
//  CPSKeyIndustriesCollectionCellPresenter.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/28.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSKeyIndustriesCollectionCellPresenter.h"

#import "CPSKeyIndustriesCollectionViewCell.h"

@implementation CPSKeyIndustriesCollectionCellPresenter

- (void)configureCell:(CPSKeyIndustriesCollectionViewCell *)cell
              forItem:(id)item
          atIndexPath:(NSIndexPath *)indexPath
     inCollectionView:(UICollectionView *)collectionView
{
    cell.textView.text = [self.dataProvider titleForItem:item];
    cell.imageView.image = [self.dataProvider iconForItem:item];
    
    if (self.hidesTextView)
    {
        cell.textView.hidden = YES;
    }
    else
    {
        cell.textView.hidden = NO;
    }
}

@end
