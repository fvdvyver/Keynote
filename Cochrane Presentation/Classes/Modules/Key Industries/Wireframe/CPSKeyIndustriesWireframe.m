//
//  CPSKeyIndustriesWireframe.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/27.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSKeyIndustriesWireframe.h"

#import "CPSCachedViewControllerProvider.h"

#import "CPSPlaceholderWireframe.h"
#import "CPSPlaceholderPresenter.h"

@interface CPSKeyIndustriesWireframe ()

@property (nonatomic, strong) UIViewController * mainViewController;

@end

@implementation CPSKeyIndustriesWireframe

- (void)prepareContentViewController
{
    // purge the cached content view controller because we have been requested to provide a new one
    self.mainViewController = nil;
}

- (UIViewController *)contentViewController
{
    UIViewController *viewController = [super contentViewController];
    self.mainViewController = viewController;
    
    return viewController;
}

- (void)showMainViewController
{
    [self.parentContentWireframe setContentControllerProvider:[CPSCachedViewControllerProvider providerWithCachedViewController:self.mainViewController]];
}

- (void)showIndustryWithTitle:(NSString *)title imageName:(NSString *)imageName
{
    CPSPlaceholderWireframe *wireframe = [CPSPlaceholderWireframe wireframeWithStoryboardName:self.storyboardName placeholderText:title];
    wireframe.presenter = [CPSPlaceholderPresenter new];
    [wireframe.presenter setWireframe:self];
    
    [self.parentContentWireframe setContentControllerProvider:wireframe];
}

- (void)advanceCurrentContentProvider
{
    [self showMainViewController];
}

- (void)navigateToProductRange
{
#warning TODO: change navigation system so we can specify which menu item to navigate to
    [self.parentContentWireframe advanceCurrentContentProvider];
}

@end
