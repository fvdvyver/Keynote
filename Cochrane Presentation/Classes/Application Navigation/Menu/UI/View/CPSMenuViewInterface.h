//
//  CPSMenuViewInterface.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/11.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CPSMenuItemCellInterface.h"

/**
 *  The interface a view representing a menu must conform to. 
 *  An implicit requirement is that the tableview cells used must conform to CPSMenuItemCellInterface
 */
@protocol CPSMenuViewInterface <NSObject>

- (void)setSelectedIndexPath:(NSIndexPath *)indexPath;
- (void)setTableViewDatasource:(id<UITableViewDataSource>)datasource;
- (void)setTableViewDelegate:(id<UITableViewDelegate>)delegate;

// This must return the cell reuse identifier the view uses for the menu cells
- (NSString *)menuItemCellReuseIdentifier;

@end

@protocol CPSMenuViewEventHandler <NSObject>

- (void)updateDatasource;
- (void)updateSelection;

@end
