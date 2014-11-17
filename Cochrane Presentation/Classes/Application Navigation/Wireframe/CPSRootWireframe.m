//
//  CPSRootWireframe.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/10.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSRootWireframe.h"

@implementation CPSRootWireframe

- (void)setMenuControllerProvider:(id<CPSViewControllerProvider>)menuControllerProvider
{
    _menuControllerProvider = menuControllerProvider;
    [self.presenter setMenuViewController:[self.menuControllerProvider contentViewController]];
}

- (void)setContentControllerProvider:(id<CPSViewControllerProvider>)contentControllerProvider
{
    _contentControllerProvider = contentControllerProvider;
    [self.presenter setContentViewController:[self.contentControllerProvider contentViewController]];
}

@end
