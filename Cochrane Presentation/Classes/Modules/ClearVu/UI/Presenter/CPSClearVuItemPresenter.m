//
//  CPSClearVuItemPresenter.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/10.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSClearVuItemPresenter.h"

#import "CPSAssetItem.h"

@implementation CPSClearVuItemPresenter

- (void)configureCell:(id<CPSClearVuItemView>)cell
              forItem:(CPSAssetItem *)item
          atIndexPath:(NSIndexPath *)indexPath
          inTableView:(UITableView *)tableView
{
    if (item.secondaryFilename.length > 0)
    {
        [cell playVideoWithName:item.secondaryFilename];
    }
    else
    {
        [cell setTitle:[item.title uppercaseString]];
    }
}

@end
