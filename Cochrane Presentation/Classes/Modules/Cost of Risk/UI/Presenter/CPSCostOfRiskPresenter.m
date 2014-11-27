//
//  CPSCostOfRiskPresenter.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/24.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSCostOfRiskPresenter.h"

#import "CPSBaseWireframe.h"

#import "MCArrayTableViewDatasource.h"
#import "CPSCostOfRiskCellPresenter.h"

#import "CPSCostOfRiskTableViewDelegate.h"

@interface CPSCostOfRiskPresenter () <MCMenuTableViewDelegateEventHandler>

@property (nonatomic, strong) MCArrayTableViewDatasource *     datasource;
@property (nonatomic, strong) CPSCostOfRiskTableViewDelegate * delegate;

@property (nonatomic, strong) CPSCostOfRiskCellPresenter * cellPresenter;

- (void)setupDatasource;

@end

@implementation CPSCostOfRiskPresenter

@synthesize wireframe = _wireframe;

- (void)setupDatasource
{
    self.cellPresenter = [CPSCostOfRiskCellPresenter new];
    
    NSString *cellIdentifier = [self.userInterface cellReuseIdentifier];
    self.datasource = [[MCArrayTableViewDatasource alloc] initWithItems:nil
                                                         cellIdentifier:cellIdentifier
                                                              presenter:self.cellPresenter];
    
    self.delegate = [CPSCostOfRiskTableViewDelegate new];
    self.delegate.eventHandler = self;
}

- (void)updateView
{
    if (self.datasource == nil)
    {
        [self setupDatasource];
    }
    
    [self.userInterface setTableViewDatasource:self.datasource];
    [self.userInterface setTableViewDelegate:self.delegate];
    
    [super updateView];
}

- (void)introVideoPlaybackCompleted
{
    [super introVideoPlaybackCompleted];
    [self.interactor advanceCurrentItem];
}

- (void)handleSingleTap
{
    [self.interactor advanceCurrentItem];
}

- (void)handleDoubleTap
{
    [self.wireframe advanceCurrentContentProvider];
}

- (void)resetState
{
    [self.datasource setItems:nil];
    [self.userInterface reloadData];
}

- (void)addItem:(NSString *)itemTitle
{
    [self.delegate stopAnimatingCells];
    
    NSUInteger count = [self.datasource count];
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:count inSection:0];
    
    [self.cellPresenter setSelectedIndexPath:newIndexPath];
    [self.datasource addItem:itemTitle];
    [self.delegate setIndexPathToAnimate:newIndexPath];
    [self.userInterface addRowAtIndexPath:newIndexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.cellPresenter setSelectedIndexPath:indexPath];
    [self.interactor itemSelectedAtIndex:[indexPath row]];
}

@end
