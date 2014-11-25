//
//  CPSMenuTableViewController.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/12.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSMenuTableViewController.h"

#import "CPSMenuItemTableViewCell.h"
#import "UITableView+CPSBorderMaskStretchAdditions.h"

@interface CPSMenuTableViewController ()

- (void)configureTableView;

@end

@implementation CPSMenuTableViewController

- (void)configureTableView
{
    self.tableView.dataSource = nil;
    self.tableView.delegate = nil;
    [self.tableView registerClass:[CPSMenuItemTableViewCell class]
           forCellReuseIdentifier:[self menuItemCellReuseIdentifier]];
    
    [self.tableView cps_configureTableViewInsetsForMask];
    [self.tableView cps_configureTableViewMask];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureTableView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CALayer *maskLayer = self.tableView.layer.mask;
    CGRect maskFrame = maskLayer.frame;
    
    maskFrame.size.height = CGRectGetHeight(self.tableView.bounds);
    
    maskLayer.frame = maskFrame;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.tableView.dataSource == nil)
    {
        [self.eventHandler updateDatasource];
    }
    [self.eventHandler updateSelection];
}

- (void)setSelectedIndexPath:(NSIndexPath *)indexPath
{
    BOOL animate = [self isViewLoaded];
    [self.tableView selectRowAtIndexPath:indexPath animated:animate scrollPosition:UITableViewScrollPositionNone];
}

- (void)setTableViewDatasource:(id<UITableViewDataSource>)datasource
{
    [self.tableView setDataSource:datasource];
}

- (void)setTableViewDelegate:(id<UITableViewDelegate>)delegate
{
    [self.tableView setDelegate:delegate];
}

- (NSString *)menuItemCellReuseIdentifier
{
    return @"menu_item_cell";
}

@end
