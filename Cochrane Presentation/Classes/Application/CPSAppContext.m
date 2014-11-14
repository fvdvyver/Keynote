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

#import "CPSPlaceholderWireframe.h"

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
                                       viewControllerProvider:introProvider],
             [[CPSViewControllerMenuItem alloc] initWithTitle:NSLocalizedString(@"Cost of Risk", nil)
                                                         icon:nil
                                       viewControllerProvider:costOfRiskProvider],
             [[CPSViewControllerMenuItem alloc] initWithTitle:NSLocalizedString(@"Uses", nil)
                                                         icon:nil
                                       viewControllerProvider:usesProvider],
             [[CPSViewControllerMenuItem alloc] initWithTitle:NSLocalizedString(@"Product Range", nil)
                                                         icon:nil
                                       viewControllerProvider:productRangeProvider],
             [[CPSViewControllerMenuItem alloc] initWithTitle:NSLocalizedString(@"Deployment Information & Specifications", nil)
                                                         icon:nil
                                       viewControllerProvider:deploymentInfoProvider],
             [[CPSViewControllerMenuItem alloc] initWithTitle:NSLocalizedString(@"ClearVu", nil)
                                                         icon:nil
                                       viewControllerProvider:clearVuProvider],
             ];
}

@end
