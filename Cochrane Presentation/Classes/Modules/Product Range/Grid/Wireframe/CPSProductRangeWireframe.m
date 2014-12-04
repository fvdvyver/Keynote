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

@property (nonatomic, strong) UIViewController * strongMainViewController;
@property (nonatomic, weak)   UIViewController * weakMainViewController;

@property (nonatomic, strong) CPSProductDetailPresenter * detailPresenter;

@end

@implementation CPSProductRangeWireframe

- (void)prepareContentViewController
{
    // purge the cached content view controller because we have been requested to provide a new one
    self.strongMainViewController = nil;
    self.weakMainViewController = nil;;
    self.detailPresenter = nil;
}

- (UIViewController *)contentViewController
{
    UIViewController *viewController = [super contentViewController];
    self.weakMainViewController = viewController;
    
    return viewController;
}

- (void)advanceCurrentContentProvider
{
    [super advanceCurrentContentProvider];
    self.strongMainViewController = nil;
}

- (void)showMainViewController
{
    self.detailPresenter = nil;
    [self.parentContentWireframe setContentControllerProvider:[CPSCachedViewControllerProvider providerWithCachedViewController:self.strongMainViewController]];
    
    // We no longer need to maintain a strong reference to the mainViewController
    self.strongMainViewController = nil;
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
    
    // We now need to maintain a strong reference to the mainViewController while it is not part of the view hierarchy
    self.strongMainViewController = self.weakMainViewController;
    
    // Do this on the next run loop so the UI can update first
    [(id)self.parentContentWireframe performSelector:@selector(setContentControllerProvider:)
                                          withObject:[CPSCachedViewControllerProvider providerWithCachedViewController:viewController]
                                          afterDelay:0.0];
}

@end
