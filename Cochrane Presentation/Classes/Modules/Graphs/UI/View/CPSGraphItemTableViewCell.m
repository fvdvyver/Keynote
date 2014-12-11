//
//  CPSGraphItemTableViewCell.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/11.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSGraphItemTableViewCell.h"

@implementation CPSGraphItemTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    UIView *backgroundView = [UIView new];
    backgroundView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.2];
    
    self.backgroundColor = [UIColor clearColor];
    self.selectedBackgroundView = backgroundView;
}

@end
