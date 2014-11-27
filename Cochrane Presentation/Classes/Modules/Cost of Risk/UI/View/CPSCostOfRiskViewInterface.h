//
//  CPSCostOfRiskViewInterface.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/24.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CPSVideoListView.h"

@protocol CPSCostOfRiskView <CPSVideoListView>

- (void)reloadData;
- (void)addRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)selectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol CPSCostOfRiskEventHandler <CPSVideoListViewEventHandler>

- (void)handleSingleTap;
- (void)handleDoubleTap;

@end
