//
//  CPSCostOfRiskCellPresenter.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/24.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MCTableViewCellPresenter.h"
#import "CPSCostOfRiskItemCellInterface.h"

@interface CPSCostOfRiskCellPresenter : NSObject <MCTableViewCellPresenter>

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

- (void)configureCell:(id<CPSCostOfRiskItemCellInterface>)cell
              forItem:(NSString *)item
          atIndexPath:(NSIndexPath *)indexPath
          inTableView:(UITableView *)tableView;

@end
