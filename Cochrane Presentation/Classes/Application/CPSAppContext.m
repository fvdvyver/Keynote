//
//  CPSAppContext.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/13.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSAppContext.h"

#import "CPSRootWireframe.h"
#import "CPSRevealRootPresenter.h"

#import "CPSMenuWireframe.h"
#import "CPSCachingMenuDelegate.h"

#import "CPSViewControllerMenuItem.h"

#import "CPSRootWireframe+MCRevealPresentation.h"

#import "CPSMenuItem.h"
#import "CPSCachedViewControllerProvider.h"

@interface CPSAppContext ()

@property (nonatomic, strong) CPSRootWireframe * rootWireframe;
@property (nonatomic, strong) CPSMenuWireframe * menuWireframe;

- (void)configureDependencies;
- (NSArray *)menuItems;

@end

@implementation CPSAppContext

- (instancetype)init
{
    if (self = [super init])
    {
        [self configureDependencies];
    }
    return self;
}

- (void)configureApplicationWithWindow:(UIWindow *)window
{
    [self.rootWireframe installRootWireframeWithRevealControllerInWindow:window];
    
    self.rootWireframe.menuControllerProvider = self.menuWireframe;
    [self.menuWireframe selectMenuItemAtIndex:0];
}

- (void)configureDependencies
{
    CPSRootWireframe *rootWireframe = [CPSRootWireframe new];
    CPSRevealRootPresenter *presenter = [CPSRevealRootPresenter new];
    
    NSArray *menuItems = [self menuItems];
    
    CPSCachingMenuDelegate *menuDelegate = [[CPSCachingMenuDelegate alloc] initWithRootWireframe:rootWireframe];
    CPSMenuWireframe *menuWireframe = [[CPSMenuWireframe alloc] initWithStoryboardName:@"Main"
                                                                             menuItems:menuItems
                                                                              delegate:menuDelegate];
    
    rootWireframe.presenter = presenter;
    
    self.rootWireframe = rootWireframe;
    self.menuWireframe = menuWireframe;
}

- (NSArray *)menuItems
{
    UIViewController *viewController = [UIViewController new];
    viewController.view.backgroundColor = [UIColor redColor];
    
    id<CPSViewControllerProvider> redProvider =  [CPSCachedViewControllerProvider providerWithCachedViewController:viewController];
    
    viewController = [UIViewController new];
    viewController.view.backgroundColor = [UIColor blueColor];
    
    id<CPSViewControllerProvider> blueProvider =  [CPSCachedViewControllerProvider providerWithCachedViewController:viewController];
    
    return @[
             [[CPSViewControllerMenuItem alloc] initWithTitle:NSLocalizedString(@"Intro", nil)
                                                         icon:nil
                                       viewControllerProvider:redProvider],
             [[CPSViewControllerMenuItem alloc] initWithTitle:NSLocalizedString(@"Cost of Risk", nil)
                                                         icon:nil
                                       viewControllerProvider:blueProvider]
             ];
}

@end
