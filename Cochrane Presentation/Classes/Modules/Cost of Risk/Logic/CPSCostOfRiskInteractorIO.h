//
//  CPSCostOfRiskInteractorIO.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/24.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSInteractor.h"
#import "CPSPresenter.h"

@protocol CPSCostOfRiskInteractorInput <CPSInteractor>

- (void)advanceCurrentItem;
- (void)itemSelectedAtIndex:(NSUInteger)index;

@end

@protocol CPSCostOfRiskInteractorOutput <CPSPresenter>

- (void)resetState;

- (void)addItem:(NSString *)itemTitle;
- (void)playVideoAtPath:(NSString *)path;

@end
