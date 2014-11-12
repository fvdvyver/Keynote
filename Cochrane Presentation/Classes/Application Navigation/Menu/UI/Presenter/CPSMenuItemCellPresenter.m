//
//  CPSMenuItemCellPresenter.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/12.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSMenuItemCellPresenter.h"

#import "CPSMenuItem.h"

@implementation CPSMenuItemCellPresenter

- (void)configureCell:(id<CPSMenuItemCellInterface>)cell
              forItem:(CPSMenuItem *)item
          atIndexPath:(NSIndexPath *)indexPath
          inTableView:(UITableView *)tableView
{
    [cell setTitle:item.title];
    [cell setIcon:item.iconImage];
}

@end
