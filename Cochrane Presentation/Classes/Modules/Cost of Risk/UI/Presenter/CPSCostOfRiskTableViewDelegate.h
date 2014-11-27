//
//  CPSCostOfRiskTableViewDelegate.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/25.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "MCTableViewDelegate.h"

/**
 *  This delegate is used to animate cells when presented. It supports only cells conforming to CPSCostOfRiskItemCellInterface
 */
@interface CPSCostOfRiskTableViewDelegate : MCTableViewDelegate

/**
 *  If non nil, the cell at this index path will animate in when the cell is presented, and then this property will be set to nil
 */
@property (nonatomic, strong) NSIndexPath *indexPathToAnimate;

- (void)stopAnimatingCells;

@end
