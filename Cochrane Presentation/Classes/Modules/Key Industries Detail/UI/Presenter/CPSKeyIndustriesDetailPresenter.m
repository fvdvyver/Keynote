//
//  CPSKeyIndustriesDetailPresenter.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/28.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSKeyIndustriesDetailPresenter.h"

@implementation CPSKeyIndustriesDetailPresenter

@synthesize interactor = _interactor;

- (void)updateView
{
    [self.userInterface setTitle:self.title];
    [self.userInterface setImage:[UIImage imageNamed:self.imageName]];
}

- (void)viewTapped
{
    [self.wireframe showMainViewController];
}

@end
