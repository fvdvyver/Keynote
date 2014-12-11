//
//  MCSimpleTableViewCellPresenter.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/11.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "MCTableViewCellPresenter.h"

/**
 *  This cell presenter will just set the text of the textLabel of the tableview cell using either the items description, or the value of a keypath of the item if set
 */
@interface MCSimpleTableViewCellPresenter : NSObject <MCTableViewCellPresenter>

@property (nonatomic, strong) NSString * dataKeyPath;

- (void)configureCell:(UITableViewCell *)cell
              forItem:(id)item
          atIndexPath:(NSIndexPath *)indexPath
          inTableView:(UITableView *)tableView;

@end
