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

#import "MCCollectionViewDelegate.h"

#import "CPSAnimatedTextView.h"

#define kCellIdentifier @"grid_cell"

@interface CPSKeyIndustriesGridViewController () <MCCollectionViewDelegateEventHandler>

@property (nonatomic, strong) id datasource;
@property (nonatomic, strong) MCCollectionViewDelegate * delegate;
@property (nonatomic, strong) CPSKeyIndustriesCollectionCellPresenter * presenter;

@property (nonatomic, assign) BOOL animateTextOnViewWillAppear;

- (void)animateCellText;

@end

@implementation CPSKeyIndustriesGridViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CPSKeyIndustriesCollectionViewCell" bundle:nil]
          forCellWithReuseIdentifier:kCellIdentifier];
    
    self.animateTextOnViewWillAppear = YES;
    [self.eventHandler updateView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.animateTextOnViewWillAppear)
    {
        self.presenter.hidesTextView = YES;
        [self.collectionView reloadData];
        
        [self performSelector:@selector(animateCellText) withObject:nil afterDelay:0.5];
        self.animateTextOnViewWillAppear = NO;
    }
    
    [self.collectionView deselectItemAtIndexPath:[[self.collectionView indexPathsForSelectedItems] firstObject]
                                        animated:YES];
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
    MCCollectionViewDelegate *delegate = [MCCollectionViewDelegate new];
    delegate.eventHandler = self;
    
    self.datasource = datasource;
    self.delegate = delegate;
    self.presenter = presenter;
    
    [self.collectionView setDataSource:datasource];
    [self.collectionView setDelegate:self.delegate];
}

- (IBAction)productsButtonTapped:(id)sender
{
    [self.eventHandler productsButtonTapped];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *items = [self.presenter.dataProvider items];
    [self.eventHandler item:items[indexPath.item] selectedAtIndex:indexPath.item];
}

@end
