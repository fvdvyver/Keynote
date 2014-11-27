//
//  CPSCostOfRiskCellPresenter.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/24.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSCostOfRiskCellPresenter.h"

@implementation CPSCostOfRiskCellPresenter

- (void)configureCell:(id<CPSCostOfRiskItemCellInterface>)cell
              forItem:(NSString *)item
          atIndexPath:(NSIndexPath *)indexPath
          inTableView:(UITableView *)tableView
{
    [cell setTitleText:item];
    
    if ([indexPath isEqual:self.selectedIndexPath])
    {
        [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
}

@end
