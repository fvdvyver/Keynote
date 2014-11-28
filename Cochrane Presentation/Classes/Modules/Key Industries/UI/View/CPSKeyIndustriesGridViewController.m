//
//  CPSKeyIndustriesGridViewController.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/27.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSKeyIndustriesGridViewController.h"

#import "MCArrayCollectionViewDatasource.h"
#import "CPSKeyIndustriesCollectionCellPresenter.h"

#import "CPSAnimatedTextView.h"

#define kCellIdentifier @"grid_cell"

@interface CPSKeyIndustriesGridViewController ()

@property (nonatomic, strong) id datasource;
@property (nonatomic, strong) CPSKeyIndustriesCollectionCellPresenter * presenter;

- (void)animateCellText;

@end

@implementation CPSKeyIndustriesGridViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CPSKeyIndustriesCollectionViewCell" bundle:nil]
          forCellWithReuseIdentifier:kCellIdentifier];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.eventHandler updateView];
    
    self.presenter.hidesTextView = YES;
    [self.collectionView reloadData];
    
    [self performSelector:@selector(animateCellText) withObject:nil afterDelay:0.5];
}

- (void)animateCellText
{
    self.presenter.hidesTextView = NO;
    for (CPSAnimatedTextView *textView in [self.collectionView.visibleCells valueForKey:@"textView"])
    {
        textView.hidden = NO;
        [textView animateTextWithDuration:0.7];
    }
}

- (void)setItemDataProvider:(id<CPSKeyIndustriesItemDataProvider>)provider
{
    CPSKeyIndustriesCollectionCellPresenter *presenter = [CPSKeyIndustriesCollectionCellPresenter new];
    presenter.dataProvider = provider;
    
    id datasource = [[MCArrayCollectionViewDatasource alloc] initWithItems:[provider items]
                                                            cellIdentifier:kCellIdentifier
                                                                 presenter:presenter];
    
    self.datasource = datasource;
    self.presenter = presenter;
    
    [self.collectionView setDataSource:datasource];
}

@end
