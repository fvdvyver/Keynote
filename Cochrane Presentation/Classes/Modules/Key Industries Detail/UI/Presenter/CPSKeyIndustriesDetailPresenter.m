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
    UIImage *image = [UIImage imageNamed:self.imageName];
    if (image == nil)
    {
        NSLog(@"WARNING: content image (%@) for key industry item %@ not found", self.imageName, self.title);
    }
    
    [self.userInterface setTitle:self.title];
    [self.userInterface setImage:image];
}

- (void)viewTapped
{
    [self.wireframe showMainViewController];
}

@end
