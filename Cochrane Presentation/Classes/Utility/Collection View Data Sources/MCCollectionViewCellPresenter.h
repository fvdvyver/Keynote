//
//  MCCollectionViewCellPresenter.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/27.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCCollectionViewCellPresenter <NSObject>

@required
- (void)configureCell:(id)cell forItem:(id)item atIndexPath:(NSIndexPath *)indexPath inCollectionView:(UICollectionView *)collectionView;

@end

@protocol MCCollectionSupplementaryViewPresenter <NSObject>

- (void)configureSupplementaryView:(id)view withData:(id)sectionData atIndexPath:(NSIndexPath *)indexPath inCollectionView:(UICollectionView *)collectionView;

@end
