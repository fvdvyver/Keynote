//
//  UITableView+CPSMaskingAdditions.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/05.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (CPSMaskingAdditions)

+ (UIEdgeInsets)cps_insetsForCostOfRiskTableMask;
+ (UIEdgeInsets)cps_insetsForInfoAndSpecsTableMask;

+ (NSString *)cps_maskImageNameForCostOfRiskTable;
+ (NSString *)cps_maskImageNameForInfoAndSpecsTable;

- (void)cps_configureTableViewMaskWithImage:(NSString *)imageName insets:(UIEdgeInsets)insets;

@end
