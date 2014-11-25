//
//  UITableView+CPSBorderMaskStretchAdditions.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/24.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "UITableView+CPSBorderMaskStretchAdditions.h"

@implementation UITableView (CPSBorderMaskStretchAdditions)

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

- (void)cps_configureTableViewMask
{
    UIEdgeInsets insets = self.contentInset;
    
    UIImage *maskImage = [UIImage imageNamed:@"left_border_line_stretch_mask"];
    CALayer *maskLayer = [CALayer layer];
    maskLayer.contentsScale = [[UIScreen mainScreen] scale];
    maskLayer.frame = CGRectMake(-insets.left, 0, maskImage.size.width, maskImage.size.height);
    maskLayer.contents = (id)maskImage.CGImage;
    maskLayer.actions = @{
                          @"onOrderIn"  : [NSNull null],
                          @"onOrderOut" : [NSNull null],
                          @"sublayers"  : [NSNull null],
                          @"contents"   : [NSNull null],
                          @"bounds"     : [NSNull null],
                          @"position"   : [NSNull null]
                          };
    
    CGFloat stretchHeight = maskImage.size.height - maskImage.capInsets.bottom - maskImage.capInsets.top;
    maskLayer.contentsCenter = CGRectMake(0.0,
                                          maskLayer.contentsScale * maskImage.capInsets.top / maskImage.size.width,
                                          1.0,
                                          maskLayer.contentsScale * stretchHeight / maskImage.size.height);
    
    self.layer.mask = maskLayer;
}

@end
