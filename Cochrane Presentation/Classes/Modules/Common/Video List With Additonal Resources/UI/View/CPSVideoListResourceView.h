//
//  CPSVideoListResourceView.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/12.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSVideoListView.h"

@protocol CPSVideoListResourceView <CPSVideoListView>

- (void)setAdditionalResourceButtonVisible:(BOOL)visible;
- (void)embedContentViewController:(UIViewController *)contentViewController;

@end

@protocol CPSVideoListResourceViewEventHandler <CPSVideoListViewEventHandler>

- (void)additionalResourceButtonTapped;

@end
