//
//  CPSVideoListEmbeddedContentViewController.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/12.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSVideoListEmbeddedContentViewController.h"

@interface CPSVideoListEmbeddedContentViewController ()

@property (nonatomic, strong) UIViewController * embeddedViewController;

@end

@implementation CPSVideoListEmbeddedContentViewController

- (void)removeSubviewsFromContainerView:(UIView *)containerView
{
    BOOL isContentContainer = containerView == self.contentVideoContainerView;
    if (isContentContainer)
    {
        [self.embeddedViewController willMoveToParentViewController:nil];
    }
    
    [super removeSubviewsFromContainerView:containerView];
    
    if (containerView == self.contentVideoContainerView)
    {
        [self.embeddedViewController removeFromParentViewController];
        self.embeddedViewController = nil;
    }
}

- (void)setAdditionalResourceButtonVisible:(BOOL)visible
{
    [UIView animateWithDuration:0.3 animations:^
    {
        self.additionalResourceButton.alpha = visible ? 1.0 : 0.0;
    }];
}

- (void)embedContentViewController:(UIViewController *)contentViewController
{
    
    [self removeSubviewsFromContainerView:self.contentVideoContainerView];
    
    contentViewController.view.frame = self.contentVideoContainerView.bounds;
    contentViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self addChildViewController:contentViewController];
    self.embeddedViewController = contentViewController;
    
    [self.contentVideoContainerView addSubview:contentViewController.view];
    
    contentViewController.view.alpha = 0.0;
    [UIView animateWithDuration:0.3 animations:^
    {
        contentViewController.view.alpha = 1.0;
    }
    completion:^(BOOL finished)
    {
        [contentViewController didMoveToParentViewController:contentViewController];
    }];
}

- (UIViewController *)contentViewController
{
    return _embeddedViewController;
}

- (IBAction)additionalResourceButtonTapped:(UIButton *)sender
{
    [self.eventHandler additionalResourceButtonTapped];
}

@end
