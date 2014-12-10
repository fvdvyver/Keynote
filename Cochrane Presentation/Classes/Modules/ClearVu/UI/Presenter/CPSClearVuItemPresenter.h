//
//  CPSClearVuItemPresenter.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/10.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MCTableViewCellPresenter.h"
#import "CPSClearVuItemView.h"

@class CPSAssetItem;

@interface CPSClearVuItemPresenter : NSObject <MCTableViewCellPresenter>

- (void)configureCell:(id<CPSClearVuItemView>)cell
              forItem:(CPSAssetItem *)item
          atIndexPath:(NSIndexPath *)indexPath
          inTableView:(UITableView *)tableView;

@end
