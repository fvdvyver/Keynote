//
//  MCArrayCollectionViewDatasource.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/27.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MCCollectionViewCellPresenter.h"

@interface MCArrayCollectionViewDatasource : NSObject <UICollectionViewDataSource>

/**
 *  Creates a new data source that uses presenter to configure the cells.
 *  items are copied into a new array, cellReuseIdentifier is retained and a weak reference is held to presenter.
 */
- (instancetype)initWithItems:(NSArray *)items
               cellIdentifier:(NSString *)cellReuseIdentifier
                    presenter:(id<MCCollectionViewCellPresenter>)presenter;

- (NSUInteger)count;

- (void)setItems:(NSArray *)items;
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)indexPathOfItem:(id)item;

- (NSArray *)indexPathsOfAllItems;

// Mutability methods
// Adds item at the end of the array
- (void)addItem:(id)item;
- (void)removeItem:(id)item;
- (void)removeItemAtIndex:(NSUInteger)itemIndex;

@end
