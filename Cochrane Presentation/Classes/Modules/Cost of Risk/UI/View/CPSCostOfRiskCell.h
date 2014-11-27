//
//  CPSCostOfRiskCell.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/24.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CPSCostOfRiskItemCellInterface.h"
#import "CPSAnimatedTextView.h"

@interface CPSCostOfRiskCell : UITableViewCell <CPSCostOfRiskItemCellInterface>

@property (nonatomic, strong) CPSAnimatedTextView * animatedTextView;

@end
