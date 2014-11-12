//
//  CPSMenuPresenter.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/11.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSMenuPresenter.h"

#import "MCArrayTableViewDatasource.h"
#import "CPSMenuItemCellPresenter.h"
#import "CPSMenuItemTableViewDelegate.h"

#define kCellReuseIdentifier @"menu_cell"

@interface CPSMenuPresenter () <CPSMenuItemTableViewEventHandler>

@property (nonatomic, strong) CPSMenuItemCellPresenter *   cellPresenter;
@property (nonatomic, strong) MCArrayTableViewDatasource * datasource;
@property (nonatomic, strong) CPSMenuItemTableViewDelegate * tableViewDelegate;

@end

@implementation CPSMenuPresenter

- (instancetype)init
{
    if (self = [super init])
    {
        _cellPresenter = [CPSMenuItemCellPresenter new];
    }
    return self;
}

- (void)setMenuItems:(NSArray *)menuItems
{
    self.datasource = [[MCArrayTableViewDatasource alloc] initWithItems:menuItems
                                                         cellIdentifier:kCellReuseIdentifier
                                                              presenter:self.cellPresenter];
    
    self.tableViewDelegate = [CPSMenuItemTableViewDelegate new];
    self.tableViewDelegate.eventHandler = self;

    [self.userInterface setTableViewDatasource:self.datasource];
    [self.userInterface setTableViewDelegate:self.tableViewDelegate];
}

- (void)setSelectedMenuItem:(CPSMenuItem *)menuItem
{
    [self.userInterface setSelectedIndexPath:[self.datasource indexPathOfItem:menuItem]];
}

- (void)menuItemSelectedAtIndexPath:(NSIndexPath *)indexPath
{
    CPSMenuItem *menuItem = [self.datasource itemAtIndexPath:indexPath];
    [self.input selectMenuItem:menuItem];
}

- (void)updateDatasource
{
    [self.input requestOutputDataUpdate];
}

- (void)updateSelection
{
    [self.input updateOutput];
}

@end
