//
//  CPSKeyIndustriesWireframe.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/27.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSKeyIndustriesWireframe.h"

#import "CPSCachedViewControllerProvider.h"

#import "CPSImagePagerInteractor.h"
#import "CPSKeyIndustriesDetailPresenter.h"

@interface CPSKeyIndustriesWireframe ()

@property (nonatomic, strong) UIViewController * mainViewController;
@property (nonatomic, strong) id detailInteractor;

@end

@implementation CPSKeyIndustriesWireframe

- (void)prepareContentViewController
{
    // purge the cached content view controller because we have been requested to provide a new one
    self.mainViewController = nil;
    self.detailInteractor = nil;
}

- (UIViewController *)contentViewController
{
    UIViewController *viewController = [super contentViewController];
    self.mainViewController = viewController;
    
    return viewController;
}

- (void)showMainViewController
{
    self.detailInteractor = nil;
    [self.parentContentWireframe setContentControllerProvider:[CPSCachedViewControllerProvider providerWithCachedViewController:self.mainViewController]];
}

- (void)showIndustryWithTitle:(NSString *)title imageNames:(NSArray *)imageNames
{
    CPSImagePagerInteractor *interactor = [CPSImagePagerInteractor new];
    CPSKeyIndustriesDetailPresenter *presenter = [CPSKeyIndustriesDetailPresenter new];
    UIViewController<CPSImagePagerView> *viewController = (id)[self instantiateNewViewControllerWithIdentifier:self.detailViewControllerIdentifier];
    
    interactor.title = title;
    interactor.imageResources = imageNames;
    interactor.presenter = presenter;
    
    presenter.wireframe = self;
    presenter.interactor = interactor;
    presenter.userInterface = viewController;
    
    viewController.eventHandler = presenter;
    [viewController setBackgroundVisible:YES];
    
    // Do this on the next run loop so the UI can update first
    [(id)self.parentContentWireframe performSelector:@selector(setContentControllerProvider:)
                                          withObject:[CPSCachedViewControllerProvider providerWithCachedViewController:viewController]
                                          afterDelay:0.0];
    
    self.detailInteractor = interactor;
}

- (void)navigateToProductRange
{
    [self.parentContentWireframe setContentControllerProviderWithIdentifer:@"menu.product_range"];
}

@end
