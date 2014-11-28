//
//  MCArrayCollectionViewDatasource.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/27.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "MCArrayCollectionViewDatasource.h"

@interface MCArrayCollectionViewDatasource ()

@property (nonatomic, copy)   NSMutableArray *mutableItems;
@property (nonatomic, strong) NSString *cellIdentifier;
@property (nonatomic, weak)   id<MCCollectionViewCellPresenter> presenter;

@end

@implementation MCArrayCollectionViewDatasource

- (instancetype)initWithItems:(NSArray *)items
               cellIdentifier:(NSString *)cellReuseIdentifier
                    presenter:(id<MCCollectionViewCellPresenter>)presenter
{
    if (self = [super init])
    {
        [self setItems:items];
        _cellIdentifier = cellReuseIdentifier;
        _presenter = presenter;
    }
    return self;
}

- (void)setItems:(NSArray *)items
{
    if (items == nil)
    {
        _mutableItems = [NSMutableArray array];
    }
    else
    {
        _mutableItems = [items mutableCopy];
    }
}

- (NSUInteger)count
{
    return self.mutableItems.count;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.mutableItems[indexPath.row];
}

- (NSIndexPath *)indexPathOfItem:(id)item
{
    NSInteger index = [self.mutableItems indexOfObject:item];
    return index == NSNotFound ? nil : [NSIndexPath indexPathForRow:index inSection:0];
}

- (NSArray *)indexPathsOfAllItems
{
    NSMutableArray *paths = [NSMutableArray arrayWithCapacity:self.mutableItems.count];
    for (int i = 0; i < self.mutableItems.count; ++i)
    {
        [paths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    
    return paths;
}

- (void)addItem:(id)item
{
    [self.mutableItems addObject:item];
}

- (void)removeItem:(id)item
{
    [self.mutableItems removeObject:item];
}

- (void)removeItemAtIndex:(NSUInteger)itemIndex
{
    [self.mutableItems removeObjectAtIndex:itemIndex];
}

// **********************************************************************************
#pragma mark - UITableView Datasource
// **********************************************************************************

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.mutableItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier
                                                                      forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    [self.presenter configureCell:cell forItem:item atIndexPath:indexPath inCollectionView:collectionView];
    return cell;
}

@end
