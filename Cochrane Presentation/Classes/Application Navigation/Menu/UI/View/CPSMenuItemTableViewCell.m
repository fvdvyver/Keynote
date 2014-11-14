//
//  CPSMenuItemTableViewCell.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/13.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSMenuItemTableViewCell.h"

#import "CPSAppearanceConfig.h"

@implementation CPSMenuItemTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.font = [UIFont fontWithName:kCPSApplicationFontDefaultName size:19];
        
        UIView *backgroundView = [UIView new];
        backgroundView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.2];
        
        self.selectedBackgroundView = backgroundView;
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    self.textLabel.text = title;
}

- (void)setIcon:(UIImage *)icon
{
    self.imageView.image = icon;
}

@end
