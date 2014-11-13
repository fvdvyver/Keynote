//
//  CPSRootWireframe+MCRevealPresentation.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/13.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSRootWireframe+MCRevealPresentation.h"

#import <MCRevealController.h>
#import "CPSRevealRootPresenter.h"

@implementation CPSRootWireframe (MCRevealPresentation)

- (void)installRootWireframeWithRevealControllerInWindow:(UIWindow *)window
{
    MCRevealController *revealController = (id)[window rootViewController];
    [self.presenter setRootUserInterface:revealController];
}

@end
