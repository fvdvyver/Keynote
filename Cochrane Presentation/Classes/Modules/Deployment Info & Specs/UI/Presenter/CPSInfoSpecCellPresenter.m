//
//  CPSInfoSpecCellPresenter.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/05.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSInfoSpecCellPresenter.h"

#import "CPSInfoSpecItemView.h"

@implementation CPSInfoSpecCellPresenter

- (void)configureCell:(id<CPSInfoSpecItemView>)cell
              forItem:(NSString *)item
          atIndexPath:(NSIndexPath *)indexPath
          inTableView:(UITableView *)tableView
{
    [cell setTitleText:item];
}

@end
