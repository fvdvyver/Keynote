//
//  CPSMenuTableViewController.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/12.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSMenuTableViewController.h"

@implementation CPSMenuTableViewController

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

@end
