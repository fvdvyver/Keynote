//
//  CPSMenuItemCellPresenter.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/12.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MCTableViewCellPresenter.h"
#import "CPSMenuItemCellInterface.h"

@class CPSMenuItem;

@interface CPSMenuItemCellPresenter : NSObject <MCTableViewCellPresenter>

- (void)configureCell:(id<CPSMenuItemCellInterface>)cell
              forItem:(CPSMenuItem *)item
          atIndexPath:(NSIndexPath *)indexPath
          inTableView:(UITableView *)tableView;

@end
