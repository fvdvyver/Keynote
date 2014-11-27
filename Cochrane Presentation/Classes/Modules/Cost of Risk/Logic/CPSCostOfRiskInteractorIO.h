//
//  CPSCostOfRiskInteractorIO.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/24.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSVideoListInteractorIO.h"

@protocol CPSCostOfRiskInteractorInput <CPSVideoListInteractorInput>

- (void)advanceCurrentItem;

@end

@protocol CPSCostOfRiskInteractorOutput <CPSVideoListInteractorOutput>

- (void)resetState;
- (void)addItem:(NSString *)itemTitle;

@end
