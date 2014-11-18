//
//  CPSRootWireframeTests.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/06.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "CPSRootWireframe.h"

@interface CPSRootWireframeTests : XCTestCase

@property (nonatomic, strong) CPSRootWireframe * wireframe;

@property (nonatomic, strong) id<CPSRootPresenter> presenter;
@property (nonatomic, strong) id<CPSViewControllerProvider> controllerProvider;
@property (nonatomic, strong) UIViewController * viewController;

@end

@implementation CPSRootWireframeTests

- (void)setUp
{
    [super setUp];
    
    id<CPSViewControllerProvider> controllerProvider = OCMProtocolMock(@protocol(CPSViewControllerProvider));
    UIViewController *viewController = [UIViewController new];
    
    OCMStub([controllerProvider contentViewController]).andReturn(viewController);
    
    self.presenter = OCMProtocolMock(@protocol(CPSRootPresenter));
    self.controllerProvider = controllerProvider;
    self.viewController = viewController;
    
    CPSRootWireframe *wireframe = [CPSRootWireframe new];
    wireframe.presenter = self.presenter;
    
    self.wireframe = wireframe;
}

- (void)tearDown
{
    self.wireframe = nil;
    self.presenter = nil;
    self.controllerProvider = nil;
    self.viewController = nil;
    
    [super tearDown];
}

- (void)testSettingMenuControllerProviderUpdatesPresentersMenuViewController
{
    self.wireframe.menuControllerProvider = self.controllerProvider;
    
    id presenter = self.presenter;
    OCMVerify([presenter setMenuViewController:self.viewController]);
}

- (void)testSettingContentControllerProviderUpdatesPresentersContentViewController
{
    self.wireframe.contentControllerProvider = self.controllerProvider;
    
    id presenter = self.presenter;
    OCMVerify([presenter setContentViewController:self.viewController]);
}

@end
