//
//  CPSKeyIndustriesViewInterface.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/27.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CPSView.h"
#import "CPSPresenter.h"

@protocol CPSKeyIndustriesItemDataProvider <NSObject>

- (NSArray *)items;

- (NSString *)titleForItem:(id)item;
- (UIImage *)iconForItem:(id)item;

@end

@protocol CPSKeyIndustriesView <CPSView>

- (void)setItemDataProvider:(id<CPSKeyIndustriesItemDataProvider>)provider;

@end

@protocol CPSKeyIndustriesViewEventHandler <CPSPresenter>

- (void)updateView;
- (void)item:(id)item selectedAtIndex:(NSInteger)index;
- (void)productsButtonTapped;

@end
