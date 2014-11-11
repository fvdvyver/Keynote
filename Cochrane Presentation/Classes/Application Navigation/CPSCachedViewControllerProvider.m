//
//  CPSCachedViewControllerProvider.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/11.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSCachedViewControllerProvider.h"

@interface CPSCachedViewControllerProvider ()
{
    UIViewController *_viewController;
}

@end

@implementation CPSCachedViewControllerProvider

+ (instancetype)providerWithCachedViewController:(UIViewController *)viewController
{
    CPSCachedViewControllerProvider *provider = [[self class] new];
    provider->_viewController = viewController;
    
    return provider;
}

- (UIViewController *)contentViewController
{
    return _viewController;
}

@end
