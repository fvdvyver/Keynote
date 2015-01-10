//
//  CPSKeyIndustriesWireframe.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/27.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSKeyIndustriesWireframe.h"

#import "CPSCachedViewControllerProvider.h"

#import "CPSKeyIndustriesDetailPresenter.h"

@interface CPSKeyIndustriesWireframe ()

@property (nonatomic, strong) UIViewController * mainViewController;
@property (nonatomic, strong) CPSKeyIndustriesDetailPresenter * detailPresenter;

@end

@implementation CPSKeyIndustriesWireframe

- (void)prepareContentViewController
{
    // purge the cached content view controller because we have been requested to provide a new one
    self.mainViewController = nil;
    self.detailPresenter = nil;
}

- (UIViewController *)contentViewController
{
    UIViewController *viewController = [super contentViewController];
    self.mainViewController = viewController;
    
    return viewController;
}

- (void)showMainViewController
{
    self.detailPresenter = nil;
    [self.parentContentWireframe setContentControllerProvider:[CPSCachedViewControllerProvider providerWithCachedViewController:self.mainViewController]];
}

- (void)showIndustryWithTitle:(NSString *)title imageNames:(NSArray *)imageNames
{
    UIViewController<CPSView> *viewController = (id)[self instantiateNewViewControllerWithIdentifier:self.detailViewControllerIdentifier];
    CPSKeyIndustriesDetailPresenter *presenter = [CPSKeyIndustriesDetailPresenter new];
    presenter.title = title;
    presenter.imageNames = imageNames;
    
    viewController.eventHandler = presenter;
    
    presenter.wireframe = self;
    presenter.userInterface = (id)viewController;
    
    self.detailPresenter = presenter;
    
    // Do this on the next run loop so the UI can update first
    [(id)self.parentContentWireframe performSelector:@selector(setContentControllerProvider:)
                                          withObject:[CPSCachedViewControllerProvider providerWithCachedViewController:viewController]
                                          afterDelay:0.0];
}

- (void)navigateToProductRange
{
    [self.parentContentWireframe setContentControllerProviderWithIdentifer:@"menu.product_range"];
}

@end
