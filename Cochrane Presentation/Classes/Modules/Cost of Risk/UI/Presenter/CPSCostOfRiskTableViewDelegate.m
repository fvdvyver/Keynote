//
//  CPSCostOfRiskTableViewDelegate.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/25.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSCostOfRiskTableViewDelegate.h"

#import "CPSCostOfRiskItemCellInterface.h"

@interface CPSCostOfRiskTableViewDelegate ()

@property (nonatomic, weak) id<CPSCostOfRiskItemCellInterface> animatingCell;

@end

@implementation CPSCostOfRiskTableViewDelegate

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(id<CPSCostOfRiskItemCellInterface>)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath isEqual:self.indexPathToAnimate])
    {
        [cell animateIn];
        self.indexPathToAnimate = nil;
        self.animatingCell = cell;
    }
}

- (void)stopAnimatingCells;
{
    [self.animatingCell stopAnimating];
}

@end
