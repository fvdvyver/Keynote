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

#import "CPSRootWireframe+MCRevealPresentation.h"

#import "CPSMenuItem.h"
#import "CPSCachedViewControllerProvider.h"

@interface CPSAppContext ()

@property (nonatomic, strong) CPSRootWireframe * rootWireframe;
@property (nonatomic, strong) CPSMenuWireframe * menuWireframe;

- (void)configureDependencies;

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
    
    UIViewController *viewController = [UIViewController new];
    viewController.view.backgroundColor = [UIColor redColor];
    
    self.rootWireframe.menuControllerProvider = self.menuWireframe;
    self.rootWireframe.contentControllerProvider = [CPSCachedViewControllerProvider providerWithCachedViewController:viewController];
}

- (void)configureDependencies
{
    CPSRootWireframe *rootWireframe = [CPSRootWireframe new];
    CPSRevealRootPresenter *presenter = [CPSRevealRootPresenter new];
    
    NSArray *menuItems = @[
                           [[CPSMenuItem alloc] initWithTitle:@"Slide 1" icon:nil],
                           [[CPSMenuItem alloc] initWithTitle:@"Slide 2" icon:nil]
                           ];
    
    CPSCachingMenuDelegate *menuDelegate = [[CPSCachingMenuDelegate alloc] initWithRootWireframe:rootWireframe];
    CPSMenuWireframe *menuWireframe = [[CPSMenuWireframe alloc] initWithMenuItems:menuItems delegate:menuDelegate];
    
    rootWireframe.presenter = presenter;
    
    self.rootWireframe = rootWireframe;
    self.menuWireframe = menuWireframe;
}

@end
