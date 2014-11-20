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
#import "CPSRootWireframeMenuDelegate.h"

#import "CPSRootContentWireframe.h"

#import "CPSViewControllerMenuItem.h"

#import "CPSRootWireframe+MCRevealPresentation.h"

#import "CPSMenuItem.h"
#import "CPSViewControllerContentWireframe.h"

#import "CPSBaseWireframe.h"
#import "CPSAccessPagePresenter.h"
#import "CPSAccessPageViewController.h"

#import "CPSPlaceholderWireframe.h"

@interface CPSAppContext ()

@property (nonatomic, strong) CPSRootWireframe * rootWireframe;
@property (nonatomic, strong) CPSMenuWireframe * menuWireframe;
@property (nonatomic, strong) CPSRootContentWireframe *contentWireframe;

- (void)configureDependencies;

- (NSArray *)menuItems;
- (CPSViewControllerContentWireframe *)contentWireframeForProviders:(NSArray *)providers;

- (void)injectContentWireframe:(id<CPSContentWireframe>)contentWireframe asParentOfWireframe:(id)subwireframe;
- (void)injectContentWireframe:(id<CPSContentWireframe>)wireframe asParentOfMenuItems:(NSArray *)menuItems;

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
    
    CPSRootWireframeMenuDelegate *menuDelegate = [[CPSRootWireframeMenuDelegate alloc] initWithRootWireframe:rootWireframe];
    CPSMenuWireframe *menuWireframe = [[CPSMenuWireframe alloc] initWithStoryboardName:@"Main"
                                                                             menuItems:menuItems
                                                                              delegate:menuDelegate];
    
    rootWireframe.presenter = presenter;
    
    CPSRootContentWireframe *contentWireframe = [CPSRootContentWireframe new];
    contentWireframe.rootWireframe = rootWireframe;
    contentWireframe.menuWireframe = menuWireframe;
    
    [self injectContentWireframe:contentWireframe asParentOfMenuItems:menuItems];
    
    self.rootWireframe = rootWireframe;
    self.menuWireframe = menuWireframe;
    self.contentWireframe = contentWireframe;
}

- (NSArray *)menuItems
{
    CPSBaseWireframe *accessWireframe = [CPSBaseWireframe wireframeWithStoryboardName:@"Main"
                                                                     viewControllerID:@"AccessPageViewController"];
    CPSAccessPagePresenter *presenter = [CPSAccessPagePresenter new];
    
    accessWireframe.presenter = presenter;
    presenter.wireframe = accessWireframe;
    
    CPSPlaceholderWireframe *introProvider = [CPSPlaceholderWireframe wireframeWithStoryboardName:@"Main"
                                                                                  placeholderText:NSLocalizedString(@"Introduction Video", nil)];
    CPSPlaceholderWireframe *costOfRiskProvider = [CPSPlaceholderWireframe wireframeWithStoryboardName:@"Main"
                                                                                       placeholderText:NSLocalizedString(@"Cost of Risk Page", nil)];
    CPSPlaceholderWireframe *usesProvider = [CPSPlaceholderWireframe wireframeWithStoryboardName:@"Main"
                                                                                       placeholderText:NSLocalizedString(@"Uses Page", nil)];
    CPSPlaceholderWireframe *productRangeProvider = [CPSPlaceholderWireframe wireframeWithStoryboardName:@"Main"
                                                                                       placeholderText:NSLocalizedString(@"Product Range Page", nil)];
    CPSPlaceholderWireframe *deploymentInfoProvider = [CPSPlaceholderWireframe wireframeWithStoryboardName:@"Main"
                                                                                       placeholderText:NSLocalizedString(@"Deployment Information & Specifications Page", nil)];
    CPSPlaceholderWireframe *clearVuProvider = [CPSPlaceholderWireframe wireframeWithStoryboardName:@"Main"
                                                                                       placeholderText:NSLocalizedString(@"ClearVu Page", nil)];
    
    return @[
             [[CPSViewControllerMenuItem alloc] initWithTitle:NSLocalizedString(@"Intro", nil)
                                                         icon:nil
                                       viewControllerProvider:[self contentWireframeForProviders:@[ accessWireframe, introProvider ]] ],
             [[CPSViewControllerMenuItem alloc] initWithTitle:NSLocalizedString(@"Cost of Risk", nil)
                                                         icon:nil
                                       viewControllerProvider:[self contentWireframeForProviders:@[ costOfRiskProvider ]] ],
             [[CPSViewControllerMenuItem alloc] initWithTitle:NSLocalizedString(@"Uses", nil)
                                                         icon:nil
                                       viewControllerProvider:[self contentWireframeForProviders:@[ usesProvider ]] ],
             [[CPSViewControllerMenuItem alloc] initWithTitle:NSLocalizedString(@"Product Range", nil)
                                                         icon:nil
                                       viewControllerProvider:[self contentWireframeForProviders:@[ productRangeProvider ]] ],
             [[CPSViewControllerMenuItem alloc] initWithTitle:NSLocalizedString(@"Deployment Information & Specifications", nil)
                                                         icon:nil
                                       viewControllerProvider:[self contentWireframeForProviders:@[ deploymentInfoProvider ]] ],
             [[CPSViewControllerMenuItem alloc] initWithTitle:NSLocalizedString(@"ClearVu", nil)
                                                         icon:nil
                                       viewControllerProvider:[self contentWireframeForProviders:@[ clearVuProvider ]] ]
             ];
}

- (CPSViewControllerContentWireframe *)contentWireframeForProviders:(NSArray *)providers
{
    CPSViewControllerContentWireframe *wireframe = [CPSViewControllerContentWireframe new];
    wireframe.contentProviders = providers;
    
    for (id provider in providers)
    {
        [self injectContentWireframe:wireframe asParentOfWireframe:provider];
    }
    
    return wireframe;
}

- (void)injectContentWireframe:(id<CPSContentWireframe>)contentWireframe asParentOfWireframe:(id)subwireframe
{
    if ([subwireframe respondsToSelector:@selector(setParentContentWireframe:)])
    {
        [subwireframe setParentContentWireframe:contentWireframe];
    }
}

- (void)injectContentWireframe:(id<CPSContentWireframe>)contentWireframe asParentOfMenuItems:(NSArray *)menuItems
{
    for (CPSMenuItem *menuItem in menuItems)
    {
        if ([menuItem isKindOfClass:[CPSViewControllerMenuItem class]])
        {
            CPSViewControllerMenuItem *controllerItem = (id)menuItem;
            id provider = [controllerItem viewControllerProvider];
            
            [self injectContentWireframe:contentWireframe asParentOfWireframe:provider];
        }
    }
}

@end
