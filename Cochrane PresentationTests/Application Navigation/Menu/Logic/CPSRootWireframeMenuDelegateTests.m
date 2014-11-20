//
//  CPSRootWireframeMenuDelegateTests.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/20.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "CPSRootWireframeMenuDelegate.h"
#import "CPSRootWireframe.h"

@interface CPSRootWireframeMenuDelegateTests : XCTestCase

@property (nonatomic, strong) CPSRootWireframeMenuDelegate * menuDelegate;

// mock objects
@property (nonatomic, strong) id rootWireframe;
@property (nonatomic, strong) id menuItem;
@property (nonatomic, strong) id viewControllerProvider;
@property (nonatomic, strong) UIViewController * contentViewController;

@end

@implementation CPSRootWireframeMenuDelegateTests

- (void)setUp
{
    [super setUp];
    
    id wireframe = OCMClassMock([CPSRootWireframe class]);
    id menuItem = OCMClassMock([CPSViewControllerMenuItem class]);
    id viewControllerProvider = OCMProtocolMock(@protocol(CPSViewControllerProvider));
    id viewController = [UIViewController new];
    
    OCMStub([menuItem viewControllerProvider]).andReturn(viewControllerProvider);
    OCMStub([viewControllerProvider contentViewController]).andReturn(viewController);
    
    CPSRootWireframeMenuDelegate *menuDelegate = [[CPSRootWireframeMenuDelegate alloc] initWithRootWireframe:wireframe];
    
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

@end
