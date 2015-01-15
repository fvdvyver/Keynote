//
//  CPSResourceListView.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/13.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSView.h"
#import "CPSPresenter.h"

#import "CPSResourceListDataProvider.h"

@protocol CPSResourceListView <CPSView>

- (void)setResourceListDataProvider:(id<CPSResourceListDataProvider>)provider;
- (void)setViewInsetsString:(NSString *)insetsString;

- (void)hideBackgroundView;

@end

@protocol CPSResourceListViewEventHandler <CPSPresenter>

- (void)updateView;
- (void)itemSelectedAtIndexPath:(NSIndexPath *)indexPath;

@end
