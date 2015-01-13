//
//  MCSectionedCollectionViewDataSource.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/13.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "MCSectionedCollectionViewDataSource.h"

@interface MCSectionedCollectionViewDataSource ()

@property (nonatomic, weak) id<MCCollectionViewSectionDataProvider> dataProvider;
@property (nonatomic, weak) id<MCCollectionViewCellPresenter>       presenter;

@property (nonatomic, strong) NSString *cellIdentifier;

@end

@implementation MCSectionedCollectionViewDataSource

- (instancetype)initWithDataProvider:(id<MCCollectionViewSectionDataProvider>)provider
                           presenter:(id<MCCollectionViewCellPresenter>)presenter
                      cellIdentifier:(NSString *)cellReuseIdentifier
{
    if (self = [super init])
    {
        _dataProvider = provider;
        _presenter = presenter;
        _cellIdentifier = cellReuseIdentifier;
    }
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataProvider itemAtIndexPath:indexPath];
}

// **********************************************************************************
#pragma mark - UITableView Datasource
// **********************************************************************************

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.dataProvider numberOfSections];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataProvider numberOfItemsInSection:section];
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
