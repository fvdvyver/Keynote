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

#import "CPSImageViewAnimator.h"

#define kCellIdentifier @"cell"

@interface CPSProductRangeGridViewController () <UICollectionViewDelegate>

@property (nonatomic, strong) MCArrayCollectionViewDatasource * datasource;

@property (nonatomic, strong) id<CPSProductItemPresenter> itemPresenter;
@property (nonatomic, strong) CPSProductItemCollectionCellPresenter * presenter;


@property (nonatomic, assign) BOOL animateTextOnViewWillAppear;

- (void)animateCellText;

@end

@implementation CPSProductRangeGridViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"CPSProductItemCollectionViewCell" bundle:nil]
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
    
    [[CPSImageViewAnimator sharedAnimator] setEnabled:YES];
    [[CPSImageViewAnimator sharedAnimator] setFramerate:25.0];
    
    [self.collectionView deselectItemAtIndexPath:[[self.collectionView indexPathsForSelectedItems] firstObject]
                                        animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[CPSImageViewAnimator sharedAnimator] setEnabled:YES];
}

- (void)setItemPresenter:(id<CPSProductItemPresenter>)itemPresenter
{
    _itemPresenter = itemPresenter;
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

- (void)animateCellText
{
    self.presenter.hidesTextView = NO;
    for (CPSAnimatedTextView *textView in [self.collectionView.visibleCells valueForKey:@"textView"])
    {
        textView.hidden = NO;
        [textView animateTextWithDuration:1.2 letterRate:textView.text.length];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self.datasource itemAtIndexPath:indexPath];
    [self.eventHandler item:item selectedAtIndex:indexPath.item];
}

@end
