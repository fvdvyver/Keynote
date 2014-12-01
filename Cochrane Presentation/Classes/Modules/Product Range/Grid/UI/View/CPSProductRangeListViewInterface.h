//
//  CPSProductRangeListViewInterface.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/01.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSView.h"
#import "CPSPresenter.h"

#import "CPSProductItemView.h"

@protocol CPSProductItemPresenter <NSObject>

- (void)configureVideoView:(id<CPSProductItemVideoView>)view withItem:(id)item;

@end

@protocol CPSProductRangeListView <CPSView>

- (void)setItemPresenter:(id<CPSProductItemPresenter>)presenter;
- (void)setProductItems:(NSArray *)items;

@end

@protocol CPSProductRangeListViewEventHandler <CPSPresenter>

- (void)updateView;
- (void)item:(id)item selectedAtIndex:(NSInteger)index;

@end

