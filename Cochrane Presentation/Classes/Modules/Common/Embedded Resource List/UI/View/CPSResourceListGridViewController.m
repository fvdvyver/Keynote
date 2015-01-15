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

#import "CPSResourceListCollectionViewHeader.h"

#define kCellIdentifier @"resource_cell"
#define kHeaderIdentifier @"header"

@interface CPSResourceListGridViewController () <UICollectionViewDelegate>

@property (nonatomic, strong) MCSectionedCollectionViewDataSource * datasource;
@property (nonatomic, strong) CPSResourceDirectoryDataProviderAdapter * dataAdapter;

@end

@implementation CPSResourceListGridViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CPSResourceItemCollectionViewCell" bundle:nil]
          forCellWithReuseIdentifier:kCellIdentifier];
    [self.collectionView registerClass:[CPSResourceListCollectionViewHeader class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:kHeaderIdentifier];
    
    UICollectionViewFlowLayout *layout = (id)self.collectionView.collectionViewLayout;
    layout.headerReferenceSize = CGSizeMake(0.0, 40.0);
    
    self.collectionView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.eventHandler updateView];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.collectionView.contentInset = self.collectionViewInsets;
    self.collectionView.scrollIndicatorInsets = self.collectionViewInsets;
}

- (void)setResourceListDataProvider:(id<CPSResourceListDataProvider>)provider
{
    self.dataAdapter = [CPSResourceDirectoryDataProviderAdapter adapterWithResourceProvider:provider];
    self.datasource = [[MCSectionedCollectionViewDataSource alloc] initWithDataProvider:self.dataAdapter
                                                                              presenter:self.dataAdapter
                                                                         cellIdentifier:kCellIdentifier];
    [self.datasource setSupplementaryViewPresenter:self.dataAdapter identifier:kHeaderIdentifier];
    
    self.collectionView.dataSource = self.datasource;
}

- (void)setCollectionViewInsets:(UIEdgeInsets)collectionViewInsets
{
    _collectionViewInsets = collectionViewInsets;
    if ([self isViewLoaded])
    {
        [self.view setNeedsLayout];
    }
}

- (void)setViewInsetsString:(NSString *)collectionViewInsetsString
{
    self.collectionViewInsets = UIEdgeInsetsFromString(collectionViewInsetsString);
}

- (void)hideBackgroundView
{
    self.backgroundImageView.hidden = YES;
}

- (NSString *)collectionViewInsetsString
{
    return NSStringFromUIEdgeInsets(self.collectionViewInsets);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.eventHandler itemSelectedAtIndexPath:indexPath];
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

@end
