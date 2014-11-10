//
//  CPSRevealRootPresenter.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/10.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSRevealRootPresenter.h"

@implementation CPSRevealRootPresenter

- (void)setMenuViewController:(UIViewController *)menuViewController
{
    [self.revealController setLeftViewController:menuViewController];
}

- (void)setContentViewController:(UIViewController *)contentViewController
{
    [self.revealController setFrontViewController:contentViewController];
}

@end
