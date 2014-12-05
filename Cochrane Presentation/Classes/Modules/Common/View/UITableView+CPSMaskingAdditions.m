//
//  UITableView+CPSMaskingAdditions.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/05.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "UITableView+CPSMaskingAdditions.h"
#import "CALayer+CPSImplicitActionRemoval.h"

@implementation UITableView (CPSMaskingAdditions)

+ (UIEdgeInsets)cps_insetsForCostOfRiskTableMask
{
    // Configure the table view to be displayed inside the border correctly
    // Never mind the magic numbers. There are no magic numbers. What magic numbers are you talking about?
    UIEdgeInsets insets = UIEdgeInsetsZero;
    insets.top = 50;
    insets.left = 17;
    insets.bottom = 20;
    insets.right = -insets.left;
    
    return insets;
}

+ (UIEdgeInsets)cps_insetsForInfoAndSpecsTableMask
{
    return UIEdgeInsetsMake(10, 0, 0, 0);
}

+ (NSString *)cps_maskImageNameForCostOfRiskTable
{
    return @"left_border_line_stretch_mask";
}

+ (NSString *)cps_maskImageNameForInfoAndSpecsTable
{
    return @"info_specs_tableview_mask";
}

- (void)cps_configureTableViewInsetsForMask
{
    // Configure the table view to be displayed inside the border correctly
    // Never mind the magic numbers. There are no magic numbers. What magic numbers are you talking about?
    UIEdgeInsets insets = self.contentInset;
    insets.top = 50;
    insets.left = 17;
    insets.bottom = 20;
    insets.right = -insets.left;
    
    self.contentInset = insets;
}

- (void)cps_configureTableViewMaskWithImage:(NSString *)imageName insets:(UIEdgeInsets)insets
{
    self.contentInset = insets;
    
    UIImage *maskImage = [UIImage imageNamed:imageName];
    CALayer *maskLayer = [CALayer layer];
    maskLayer.contentsScale = [[UIScreen mainScreen] scale];
    maskLayer.frame = CGRectMake(-insets.left, 0, maskImage.size.width, maskImage.size.height);
    maskLayer.contents = (id)maskImage.CGImage;
    [maskLayer cps_removeImplicitActions];
    
    CGFloat stretchHeight = maskImage.size.height - maskImage.capInsets.bottom - maskImage.capInsets.top;
    maskLayer.contentsCenter = CGRectMake(0.0,
                                          maskLayer.contentsScale * maskImage.capInsets.top / maskImage.size.width,
                                          1.0,
                                          maskLayer.contentsScale * stretchHeight / maskImage.size.height);
    
    self.layer.mask = maskLayer;
}

@end
