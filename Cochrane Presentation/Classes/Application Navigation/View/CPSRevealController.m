//
//  CPSRevealController.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/14.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSRevealController.h"

@implementation CPSRevealController

- (void)setFrontViewController:(UIViewController *)frontViewController
{
    if (self.frontViewController == nil)
    {
        [super setFrontViewController:frontViewController];
    }
    else
    {
        [self showViewController:self.frontViewController animated:YES completion:^(BOOL finished)
        {
            [UIView transitionWithView:self.frontViewController.view.superview
                              duration:0.4
                               options:UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationOptionAllowAnimatedContent
                            animations:^{
                                [super setFrontViewController:frontViewController];
                            }
                            completion:nil];
        }];
    }
}

- (void)setLeftViewController:(UIViewController *)leftViewController
{
    [super setLeftViewController:leftViewController];
    [self setMinimumWidth:380 forViewController:leftViewController];
}

@end
