//
//  CPSVideoListView.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/27.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CPSView.h"
#import "CPSPresenter.h"

@protocol CPSVideoListView <CPSView>

- (NSString *)cellReuseIdentifier;

- (void)setTableViewDatasource:(id<UITableViewDataSource>)datasource;
- (void)setTableViewDelegate:(id<UITableViewDelegate>)delegate;

- (void)setUserInteractionEnabled:(BOOL)enabled;
- (void)playContentVideoAtURL:(NSURL *)url;
- (void)playBackgroundVideoAtURL:(NSURL *)url withCompletion:(dispatch_block_t)completion;

- (void)selectItemAtIndex:(NSUInteger)index;

@end

@protocol CPSVideoListViewEventHandler <CPSPresenter>

- (void)updateView;

@end
