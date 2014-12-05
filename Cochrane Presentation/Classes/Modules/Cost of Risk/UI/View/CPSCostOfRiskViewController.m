//
//  CPSCostOfRiskViewController.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/24.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSCostOfRiskViewController.h"

#import "CPSCostOfRiskCell.h"
#import "UITableView+CPSMaskingAdditions.h"

#import "MCDescendentViewGestureDelegate.h"

@interface CPSCostOfRiskViewController ()

@property (nonatomic, strong) MCDescendentViewGestureDelegate *tapGestureDelegate;

- (void)configureTableView;
- (void)configureGestureRecognisers;

- (void)handleSignleTap:(UITapGestureRecognizer *)gestureRecognizer;
- (void)handleDoubleTap:(UITapGestureRecognizer *)gestureRecognizer;

@end

@implementation CPSCostOfRiskViewController

- (void)configureTableView
{
    self.tableView.dataSource = nil;
    self.tableView.delegate = nil;
    [self.tableView registerClass:[CPSCostOfRiskCell class]
           forCellReuseIdentifier:[self cellReuseIdentifier]];
    
    [self.tableView cps_configureTableViewMaskWithImage:[UITableView cps_maskImageNameForCostOfRiskTable]
                                                 insets:[UITableView cps_insetsForCostOfRiskTableMask]];
}

- (void)configureGestureRecognisers
{
    // This gesture recogniser will ensure that tapping on a tableview cell
    // will not cause the single tap gesture to fire
    self.tapGestureDelegate = [MCDescendentViewGestureDelegate new];
    self.tapGestureDelegate.baseView = self.tableView;
    self.tapGestureDelegate.allowTouchesOnBaseView = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSignleTap:)];
    singleTap.delegate = self.tapGestureDelegate;
    
    [self.view addGestureRecognizer:singleTap];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureTableView];
    [self configureGestureRecognisers];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CALayer *maskLayer = self.tableView.layer.mask;
    CGRect maskFrame = maskLayer.frame;
    
    maskFrame.size.height = CGRectGetHeight(self.tableView.bounds);
    
    maskLayer.frame = maskFrame;
}

- (NSString *)cellReuseIdentifier
{
    return @"cost_of_risk_cell";
}

- (void)reloadData
{
    [self.tableView reloadData];
}

- (void)addRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView insertRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)selectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionBottom];
}

- (void)handleSignleTap:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.eventHandler handleSingleTap];
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.eventHandler handleDoubleTap];
}

@end
