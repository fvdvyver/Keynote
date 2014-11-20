//
//  CPSRootWireframeMenuDelegate.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/20.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSRootWireframeMenuDelegate.h"

#import "CPSRootWireframe.h"

@interface CPSRootWireframeMenuDelegate ()

@property (nonatomic, strong) CPSRootWireframe * rootWireframe;

@end

@implementation CPSRootWireframeMenuDelegate

// **********************************************************************************
#pragma mark - Object Life Cycle
// **********************************************************************************

- (instancetype)initWithRootWireframe:(CPSRootWireframe *)rootWireframe
{
    if (self = [super init])
    {
        _rootWireframe = rootWireframe;
    }
    return self;
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
    id<CPSViewControllerProvider> provider = menuItem.viewControllerProvider;
    [self.rootWireframe setContentControllerProvider:provider];
    
    return YES;
}

@end
