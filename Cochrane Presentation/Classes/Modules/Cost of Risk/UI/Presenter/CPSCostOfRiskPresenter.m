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
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"animated_background" withExtension:@"mp4"];
    
    typeof(self) __weak weakself = self;
    [self.userInterface playBackgroundVideoAtURL:url withCompletion:^
    {
        [weakself.interactor advanceCurrentItem];
    }];
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
}

- (void)addItem:(NSString *)itemTitle
{
    NSUInteger count = [self.datasource count];
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:count inSection:0];
    
    [self.cellPresenter setSelectedIndexPath:newIndexPath];
    [self.datasource addItem:[NSString stringWithFormat:@"%lu.\t%@", (unsigned long)count + 1, itemTitle]];
    [self.delegate setIndexPathToAnimate:newIndexPath];
    [self.userInterface addRowAtIndexPath:newIndexPath];
}

- (void)playVideoAtPath:(NSString *)path
{
    NSURL *url = [NSURL fileURLWithPath:path];
    [self.userInterface playContentVideoAtURL:url];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.cellPresenter setSelectedIndexPath:indexPath];
    [self.interactor itemSelectedAtIndex:[indexPath row]];
}

@end
