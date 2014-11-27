//
//  CPSCostOfRiskViewController.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/24.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CPSVideoListViewController.h"
#import "CPSCostOfRiskViewInterface.h"

@interface CPSCostOfRiskViewController : CPSVideoListViewController <CPSCostOfRiskView>

@property (nonatomic, weak) id<CPSCostOfRiskEventHandler> eventHandler;

@end
