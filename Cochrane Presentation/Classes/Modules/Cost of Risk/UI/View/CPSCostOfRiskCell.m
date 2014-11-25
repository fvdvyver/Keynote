//
//  CPSCostOfRiskCell.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/24.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSCostOfRiskCell.h"

#import "CPSAppearanceConfig.h"

@implementation CPSCostOfRiskCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.font = [UIFont fontWithName:kCPSApplicationFontDefaultName size:23];
        self.textLabel.numberOfLines = 2;
        
        UIView *backgroundView = [UIView new];
        backgroundView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.2];
        
        self.selectedBackgroundView = backgroundView;
    }
    return self;
}

- (void)setTitleText:(NSString *)text
{
    self.textLabel.text = text;
}

- (void)animateIn
{
    self.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^
    {
        self.alpha = 1.0;
    }];
}

@end
