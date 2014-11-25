//
//  CPSCostOfRiskPresenter.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/24.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSCostOfRiskInteractorIO.h"
#import "CPSCostOfRiskViewInterface.h"

@interface CPSCostOfRiskPresenter : NSObject <CPSCostOfRiskInteractorOutput, CPSCostOfRiskEventHandler>

@property (nonatomic, weak)   id <CPSCostOfRiskInteractorInput> interactor;
@property (nonatomic, strong) id <CPSCostOfRiskView> userInterface;

@end
