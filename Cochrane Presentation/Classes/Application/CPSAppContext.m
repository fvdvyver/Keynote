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
#import "CPSRootContentWireframe.h"

#import "CPSMenuWireframe.h"
#import "CPSRootWireframeMenuDelegate.h"

#import "CPSRootWireframe+MCRevealPresentation.h"

#import "CPSMenuItemLoader.h"

@interface CPSAppContext ()

@property (nonatomic, strong) CPSRootWireframe * rootWireframe;
@property (nonatomic, strong) CPSMenuWireframe * menuWireframe;
@property (nonatomic, strong) CPSRootContentWireframe *contentWireframe;

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
    
    self.rootWireframe.menuControllerProvider = self.menuWireframe;
    [self.menuWireframe selectMenuItemAtIndex:0];
}

- (void)configureDependencies
{
    CPSRootWireframe *rootWireframe = [CPSRootWireframe new];
    CPSRevealRootPresenter *presenter = [CPSRevealRootPresenter new];
    
    NSArray *menuItems = [CPSMenuItemLoader loadMenuItemsFromFile:@"menu_item_description"];
    
    CPSRootWireframeMenuDelegate *menuDelegate = [[CPSRootWireframeMenuDelegate alloc] initWithRootWireframe:rootWireframe];
    CPSMenuWireframe *menuWireframe = [[CPSMenuWireframe alloc] initWithStoryboardName:@"Main"
                                                                             menuItems:menuItems
                                                                              delegate:menuDelegate];
    
    rootWireframe.presenter = presenter;
    
    CPSRootContentWireframe *contentWireframe = [CPSRootContentWireframe new];
    contentWireframe.rootWireframe = rootWireframe;
    contentWireframe.menuWireframe = menuWireframe;
    
    [CPSMenuItemLoader injectContentWireframe:contentWireframe asParentOfMenuItems:menuItems];
    
    self.rootWireframe = rootWireframe;
    self.menuWireframe = menuWireframe;
    self.contentWireframe = contentWireframe;
}

@end
