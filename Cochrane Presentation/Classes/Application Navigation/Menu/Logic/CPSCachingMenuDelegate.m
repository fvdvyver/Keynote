//
//  CPSCachingMenuDelegate.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/11.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSCachingMenuDelegate.h"

#import "CPSRootWireframe.h"
#import "CPSCachedViewControllerProvider.h"

@interface CPSCachingMenuDelegate ()

@property (nonatomic, strong) CPSRootWireframe * rootWireframe;
@property (nonatomic, strong) NSMutableDictionary * cachedViewControllers;

- (id<CPSViewControllerProvider>)cachedControllerProviderForMenuItem:(CPSViewControllerMenuItem *)menuItem;

@end

@implementation CPSCachingMenuDelegate

// **********************************************************************************
#pragma mark - Object Life Cycle
// **********************************************************************************

- (instancetype)initWithRootWireframe:(CPSRootWireframe *)rootWireframe
{
    if (self = [super init])
    {
        _rootWireframe = rootWireframe;
        _cachedViewControllers = [NSMutableDictionary dictionary];
    }
    return self;
}

- (id<CPSViewControllerProvider>)cachedControllerProviderForMenuItem:(CPSViewControllerMenuItem *)menuItem
{
    CPSCachedViewControllerProvider *provider = self.cachedViewControllers[menuItem];
    if (provider == nil)
    {
        UIViewController *viewController = [menuItem.viewControllerProvider contentViewController];
        provider = [CPSCachedViewControllerProvider providerWithCachedViewController:viewController];
        
        self.cachedViewControllers[menuItem] = provider;
    }
    
    return provider;
}

// **********************************************************************************
#pragma mark - CPSMenuItemDelegate
// **********************************************************************************

- (BOOL)menuItemSelected:(CPSMenuItem *)menuItem
{
    return NO;
}

- (BOOL)viewControllerMenuItemSelected:(CPSViewControllerMenuItem *)menuItem
{
    id<CPSViewControllerProvider> provider = [self cachedControllerProviderForMenuItem:menuItem];
    [self.rootWireframe setContentControllerProvider:provider];
    
    return YES;
}

@end
