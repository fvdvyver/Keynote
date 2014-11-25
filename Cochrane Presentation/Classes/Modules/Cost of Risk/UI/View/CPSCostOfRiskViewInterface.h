//
//  CPSCostOfRiskViewInterface.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/24.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CPSView.h"
#import "CPSPresenter.h"

@protocol CPSCostOfRiskView <CPSView>

- (NSString *)cellReuseIdentifier;

- (void)setTableViewDatasource:(id<UITableViewDataSource>)datasource;
- (void)setTableViewDelegate:(id<UITableViewDelegate>)delegate;

- (void)reloadData;
- (void)addRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)selectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)playContentVideoAtURL:(NSURL *)url;
- (void)playBackgroundVideoAtURL:(NSURL *)url withCompletion:(dispatch_block_t)completion;

@end

@protocol CPSCostOfRiskEventHandler <CPSPresenter>

- (void)updateView;

- (void)handleSingleTap;
- (void)handleDoubleTap;

@end
