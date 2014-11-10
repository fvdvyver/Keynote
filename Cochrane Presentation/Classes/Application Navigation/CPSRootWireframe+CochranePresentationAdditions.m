//
//  CPSRootWireframe+CochranePresentationAdditions.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/10.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSRootWireframe+CochranePresentationAdditions.h"

#import <MCRevealController.h>

#import "CPSRevealRootPresenter.h"

@implementation CPSRootWireframe (CochranePresentationAdditions)

+ (CPSRootWireframe *)installRootWireframeInWindow:(UIWindow *)window
{
    MCRevealController *revealController = (id)[window rootViewController];
    
    CPSRootWireframe *wireframe = [CPSRootWireframe new];
    CPSRevealRootPresenter *presenter = [CPSRevealRootPresenter new];
    
    presenter.revealController = revealController;
    wireframe.presenter = presenter;
    
    return wireframe;
}

@end
