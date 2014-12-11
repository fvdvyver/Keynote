//
//  MCSimpleTableViewCellPresenter.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/11.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "MCSimpleTableViewCellPresenter.h"

@implementation MCSimpleTableViewCellPresenter

- (void)configureCell:(UITableViewCell *)cell
              forItem:(id)item
          atIndexPath:(NSIndexPath *)indexPath
          inTableView:(UITableView *)tableView
{
    NSString *text = nil;
    if (self.dataKeyPath == nil)
    {
        text = [item description];
    }
    else
    {
        text = [item valueForKeyPath:self.dataKeyPath];
    }
    
    cell.textLabel.text = text;
}

@end
