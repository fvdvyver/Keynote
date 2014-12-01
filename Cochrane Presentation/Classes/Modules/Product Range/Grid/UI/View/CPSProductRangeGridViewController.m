//
//  CPSProductRangeGridViewController.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/01.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSProductRangeGridViewController.h"

#import "MCArrayCollectionViewDatasource.h"
#import "CPSProductItemCollectionCellPresenter.h"

#import "CPSProductItemCollectionViewCell.h"

#define kCellIdentifier @"cell"

@interface CPSProductRangeGridViewController ()

@property (nonatomic, strong) MCArrayCollectionViewDatasource * datasource;
@property (nonatomic, strong) CPSProductItemCollectionCellPresenter * presenter;

@end

@implementation CPSProductRangeGridViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CPSProductItemCollectionViewCell" bundle:nil]
            forCellWithReuseIdentifier:kCellIdentifier];
    
    [self.eventHandler updateView];
}

- (void)setItemPresenter:(id<CPSProductItemPresenter>)itemPresenter
{
    self.presenter = [CPSProductItemCollectionCellPresenter new];
    self.presenter.itemPresenter = itemPresenter;
}

- (void)setProductItems:(NSArray *)items
{
    id datasource = [[MCArrayCollectionViewDatasource alloc] initWithItems:items
                                                            cellIdentifier:kCellIdentifier
                                                                 presenter:self.presenter];
    
    self.collectionView.dataSource = datasource;
    self.datasource = datasource;
}

@end
