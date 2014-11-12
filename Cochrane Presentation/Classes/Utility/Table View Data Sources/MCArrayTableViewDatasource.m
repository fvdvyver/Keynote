//
//  MCArrayTableViewDatasource.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/12.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "MCArrayTableViewDatasource.h"

@interface MCArrayTableViewDatasource ()

@property (nonatomic, copy) NSArray *items;
@property (nonatomic, strong) NSString *cellIdentifier;
@property (nonatomic, weak)   id<MCTableViewCellPresenter> presenter;

@end

@implementation MCArrayTableViewDatasource

- (instancetype)initWithItems:(NSArray *)items
               cellIdentifier:(NSString *)cellReuseIdentifier
                    presenter:(id<MCTableViewCellPresenter>)presenter
{
    if (self = [super init])
    {
        _items = [items copy];
        _cellIdentifier = cellReuseIdentifier;
        _presenter = presenter;
    }
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.items[indexPath.row];
}

- (NSIndexPath *)indexPathOfItem:(id)item
{
    NSInteger index = [self.items indexOfObject:item];
    return index == NSNotFound ? nil : [NSIndexPath indexPathForRow:index inSection:0];
}

- (NSArray *)indexPathsOfAllItems
{
    NSMutableArray *paths = [NSMutableArray arrayWithCapacity:self.items.count];
    for (int i = 0; i < self.items.count; ++i)
    {
        [paths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    
    return paths;
}

// **********************************************************************************
#pragma mark - UITableView Datasource
// **********************************************************************************

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier
                                                            forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    [self.presenter configureCell:cell forItem:item atIndexPath:indexPath inTableView:tableView];
    return cell;
}

@end
