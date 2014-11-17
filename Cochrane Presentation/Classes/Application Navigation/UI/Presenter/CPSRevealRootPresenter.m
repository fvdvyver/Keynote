//
//  CPSRevealRootPresenter.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/10.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSRevealRootPresenter.h"

@implementation CPSRevealRootPresenter

- (void)setRootUserInterface:(UIViewController *)rootViewController
{
    NSAssert([rootViewController isKindOfClass:[MCRevealController class]], @"CPSRevealRootPresenter only supports using an MCRevealController as its rootViewController");
    self.revealController = (MCRevealController *)rootViewController;
}

- (void)setMenuViewController:(UIViewController *)menuViewController
{
    [self.revealController setLeftViewController:menuViewController];
}

- (void)setContentViewController:(UIViewController *)contentViewController
{
    [self.revealController setFrontViewController:contentViewController];
}

@end
