//
//  CPSMenuViewInterface.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/11.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CPSMenuViewInterface <NSObject>

- (void)setSelectedIndexPath:(NSIndexPath *)indexPath;
- (void)setTableViewDatasource:(id<UITableViewDataSource>)datasource;
- (void)setTableViewDelegate:(id<UITableViewDelegate>)delegate;

@end

@protocol CPSMenuViewEventHandler <NSObject>

- (void)updateDatasource;
- (void)updateSelection;

@end
