//
//  CPSCostOfRiskInteractor.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/24.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSVideoListInteractor.h"

#import "CPSCostOfRiskInteractorIO.h"

@interface CPSCostOfRiskInteractor : CPSVideoListInteractor <CPSCostOfRiskInteractorInput>

@property (nonatomic, strong) id<CPSCostOfRiskInteractorOutput> presenter;

- (void)resetState;

@end
