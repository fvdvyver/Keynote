//
//  CPSInfoSpecCellPresenter.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/05.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCTableViewCellPresenter.h"

@interface CPSInfoSpecCellPresenter : NSObject <MCTableViewCellPresenter>

- (void)configureCell:(UITableViewCell *)cell
              forItem:(NSString *)item
          atIndexPath:(NSIndexPath *)indexPath
          inTableView:(UITableView *)tableView;

@end
