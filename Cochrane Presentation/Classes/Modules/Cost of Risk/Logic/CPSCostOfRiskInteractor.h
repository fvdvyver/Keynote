//
//  CPSCostOfRiskInteractor.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/24.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSCostOfRiskInteractorIO.h"

@interface CPSCostOfRiskInteractor : NSObject <CPSCostOfRiskInteractorInput>

@property (nonatomic, strong) id<CPSCostOfRiskInteractorOutput> presenter;

// must be an array of CPSCostOfRiskItem
@property (nonatomic, copy) NSArray *presentationItems;

- (void)resetState;

@end
