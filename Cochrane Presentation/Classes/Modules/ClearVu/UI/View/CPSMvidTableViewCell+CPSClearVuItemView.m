//
//  CPSMvidTableViewCell+CPSClearVuItemView.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/10.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSMvidTableViewCell+CPSClearVuItemView.h"

@implementation CPSMvidTableViewCell (CPSClearVuItemView)

- (void)setTitle:(NSString *)title
{
    self.textLabel.text = title;
}

- (void)playVideoWithName:(NSString *)videoName
{
    self.animatorOffset = CGSizeMake(5.5, 0.0);
    [self playMvidFileWithName:videoName];
}

@end
