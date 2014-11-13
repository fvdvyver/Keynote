//
//  CPSMenuItemTableViewCell.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/13.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSMenuItemTableViewCell.h"

@implementation CPSMenuItemTableViewCell

- (void)setTitle:(NSString *)title
{
    self.textLabel.text = title;
}

- (void)setIcon:(UIImage *)icon
{
    self.imageView.image = icon;
}

@end
