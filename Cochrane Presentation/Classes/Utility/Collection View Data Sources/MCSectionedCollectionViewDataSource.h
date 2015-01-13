//
//  MCSectionedCollectionViewDataSource.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/13.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MCCollectionViewCellPresenter.h"
#import "MCCollectionViewSectionDataProvider.h"

@interface MCSectionedCollectionViewDataSource : NSObject <UICollectionViewDataSource>

/**
 *  Creates a new data source that uses presenter to configure the cells, and provider to get section and item metadata.
 *  cellReuseIdentifier is retained and a weak reference is held to presenter and provider.
 */
- (instancetype)initWithDataProvider:(id<MCCollectionViewSectionDataProvider>)provider
                           presenter:(id<MCCollectionViewCellPresenter>)presenter
                      cellIdentifier:(NSString *)cellReuseIdentifier;

- (void)setSupplementaryViewPresenter:(id<MCCollectionSupplementaryViewPresenter>)presenter
                           identifier:(NSString *)cellReuseIdentifier;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
