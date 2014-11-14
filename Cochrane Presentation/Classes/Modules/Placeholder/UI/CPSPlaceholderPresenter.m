//
//  CPSPlaceholderPresenter.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/14.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSPlaceholderPresenter.h"

@implementation CPSPlaceholderPresenter

- (void)updateView
{
    NSString *text = self.placeholderText ?: @"";
    [self.userInterface setPlacholderText:[text stringByAppendingString:@" Placeholder View"]];
}

- (void)setPlaceholderText:(NSString *)placeholderText
{
    _placeholderText = placeholderText;
    [self updateView];
}

@end
