//
//  MCTableViewCellPresenter.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/12.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCTableViewCellPresenter <NSObject>

@required
- (void)configureCell:(id)cell forItem:(id)item atIndexPath:(NSIndexPath *)indexPath inTableView:(UITableView *)tableView;

@end
