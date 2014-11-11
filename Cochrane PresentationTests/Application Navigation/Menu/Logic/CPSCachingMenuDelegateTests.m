//
//  CPSCachingMenuDelegateTests.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/11.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "CPSCachingMenuDelegate.h"
#import "CPSRootWireframe.h"

@interface CPSCachingMenuDelegateTests : XCTestCase

@property (nonatomic, strong) CPSCachingMenuDelegate * menuDelegate;

// mock objects
@property (nonatomic, strong) id rootWireframe;
@property (nonatomic, strong) id menuItem;
@property (nonatomic, strong) id viewControllerProvider;
@property (nonatomic, strong) UIViewController * contentViewController;

@end

@implementation CPSCachingMenuDelegateTests

- (void)setUp
{
    [super setUp];
    
    id wireframe = OCMClassMock([CPSRootWireframe class]);
    id menuItem = OCMClassMock([CPSViewControllerMenuItem class]);
    id viewControllerProvider = OCMProtocolMock(@protocol(CPSViewControllerProvider));
    id viewController = [UIViewController new];

    OCMStub([menuItem viewControllerProvider]).andReturn(viewControllerProvider);
    OCMStub([viewControllerProvider contentViewController]).andReturn(viewController);
    
    CPSCachingMenuDelegate *menuDelegate = [[CPSCachingMenuDelegate alloc] initWithRootWireframe:wireframe];
    
    self.rootWireframe = wireframe;
    self.menuDelegate = menuDelegate;
    self.menuItem = menuItem;
    self.viewControllerProvider = viewControllerProvider;
    self.contentViewController = viewController;
}

- (void)tearDown
{
    self.menuDelegate = nil;
    self.rootWireframe = nil;
    self.menuItem = nil;
    self.viewControllerProvider = nil;
    self.contentViewController = nil;
    
    [super tearDown];
}

- (void)testRootWireframeIsUpdatedOnMenuItemSelection
{
    UIViewController *contentViewController = self.contentViewController;
    id wireframe = self.rootWireframe;
    id menuItem = (id)self.menuItem;
    
    OCMExpect([wireframe setContentControllerProvider:[OCMArg checkWithBlock:^BOOL(id<CPSViewControllerProvider> obj)
    {
        UIViewController *viewController = [obj contentViewController];
        return viewController == contentViewController;
    }]]);
    
    [self.menuDelegate viewControllerMenuItemSelected:menuItem];
    
    OCMVerifyAll(wireframe);
}

- (void)testMenuDelegateReturnsCachedViewController
{
    // 1. Select other menu item
    // 2. Select this menu item
    // 3. Reselect first menu item
    // 4. Ensure view controller for other item is requested once only
    // 5. Profit?
    
    id menuItem = OCMClassMock([CPSViewControllerMenuItem class]);;
    id viewControllerProvider = OCMStrictProtocolMock(@protocol(CPSViewControllerProvider)); // needs to be a strict mock
    id viewController = [UIViewController new];
    OCMStub([menuItem viewControllerProvider]).andReturn(viewControllerProvider);
    
    // The delegate sticks the menu item in a dictionary, but mock items don't conform to NSCopying
    OCMStub([menuItem copyWithZone:[OCMArg anyPointer]]).andReturn(menuItem);
    
    id otherMenuItem = (id)self.menuItem;
    
    // Must be called exactly once
    OCMExpect([viewControllerProvider contentViewController]).andReturn(viewController);
    
    [self.menuDelegate viewControllerMenuItemSelected:menuItem];
    [self.menuDelegate viewControllerMenuItemSelected:otherMenuItem];
    [self.menuDelegate viewControllerMenuItemSelected:menuItem];
    
    OCMVerifyAll(viewControllerProvider);
}

@end
