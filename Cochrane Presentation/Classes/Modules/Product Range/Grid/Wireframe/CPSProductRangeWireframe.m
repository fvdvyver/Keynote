//
//  CPSProductRangeWireframe.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/01.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSProductRangeWireframe.h"

#import "CPSProductDetailPresenter.h"
#import "CPSCachedViewControllerProvider.h"

@interface CPSProductRangeWireframe ()

@property (nonatomic, strong) UIViewController * mainViewController;
@property (nonatomic, strong) CPSProductDetailPresenter * detailPresenter;

@end

@implementation CPSProductRangeWireframe

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

- (void)showProductWithTitle:(NSString *)title videoName:(NSString *)videoName
{
    UIViewController<CPSView> *viewController = (id)[self instantiateNewViewControllerWithIdentifier:self.detailViewControllerIdentifier];
    CPSProductDetailPresenter *presenter = [CPSProductDetailPresenter new];
    presenter.title = title;
    presenter.videoName = videoName;
    
    viewController.eventHandler = presenter;
    
    presenter.wireframe = self;
    presenter.userInterface = (id)viewController;
    
    self.detailPresenter = presenter;
    
    [self.parentContentWireframe setContentControllerProvider:[CPSCachedViewControllerProvider providerWithCachedViewController:viewController]];
}

@end
