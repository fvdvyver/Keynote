//
//  CPSVideoListResourceView.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/12.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSVideoListView.h"

@protocol CPSVideoListItemResourceListDataProvider <NSObject>

- (NSInteger)numberOfSections;
- (NSInteger)numberOfItemsInSection:(NSInteger)sectionIdx;

- (NSString *)titleForSection:(NSInteger)sectionIdx;

- (UIImage *)thumbnailForItemAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)titleForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol CPSVideoListResourceView <CPSVideoListView>

- (void)setAdditionalResourceButtonVisible:(BOOL)visible;
- (void)embedContentViewController:(UIViewController *)contentViewController;

@end

@protocol CPSVideoListResourceViewEventHandler <CPSVideoListViewEventHandler>

- (void)additionalResourceButtonTapped;

@end
