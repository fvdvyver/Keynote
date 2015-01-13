//
//  CPSResourceListGridViewController.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/13.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSResourceListGridViewController.h"

#import "MCSectionedCollectionViewDataSource.h"
#import "CPSResourceDirectoryDataProviderAdapter.h"

@interface CPSResourceListGridViewController ()

@property (nonatomic, strong) MCSectionedCollectionViewDataSource * datasource;
@property (nonatomic, strong) CPSResourceDirectoryDataProviderAdapter * dataAdapter;

@end

@implementation CPSResourceListGridViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.eventHandler updateView];
}

- (void)setResourceListDataProvider:(id<CPSResourceListDataProvider>)provider
{
    self.dataAdapter = [CPSResourceDirectoryDataProviderAdapter adapterWithResourceProvider:provider];
    self.datasource = [[MCSectionedCollectionViewDataSource alloc] initWithDataProvider:self.dataAdapter
                                                                              presenter:self.dataAdapter
                                                                         cellIdentifier:self.cellReuseIdentifier];
    
    self.collectionView.dataSource = self.datasource;
}

@end
