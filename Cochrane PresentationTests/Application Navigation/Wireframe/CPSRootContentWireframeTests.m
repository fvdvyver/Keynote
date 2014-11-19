//
//  CPSRootContentWireframeTests.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/19.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "CPSRootContentWireframe.h"

@interface CPSRootContentWireframeTests : XCTestCase

@property (nonatomic, strong) CPSRootContentWireframe * contentWireframe;

@property (nonatomic, strong) CPSRootWireframe * rootWireframeMock;
@property (nonatomic, strong) CPSMenuWireframe * menuWireframeMock;

@end

@implementation CPSRootContentWireframeTests

- (void)setUp
{
    [super setUp];
    
    CPSRootWireframe *rootWireframe = OCMStrictClassMock([CPSRootWireframe class]);
    CPSMenuWireframe *menuWireframe = OCMStrictClassMock([CPSMenuWireframe class]);
    CPSRootContentWireframe *contentWireframe = [CPSRootContentWireframe new];
    
    contentWireframe.rootWireframe = rootWireframe;
    contentWireframe.menuWireframe = menuWireframe;
    
    self.contentWireframe = contentWireframe;
    self.rootWireframeMock = rootWireframe;
    self.menuWireframeMock = menuWireframe;
}

- (void)tearDown
{
    self.contentWireframe = nil;
    self.rootWireframeMock = nil;
    self.menuWireframeMock = nil;
    
    [super tearDown];
}

- (void)testSettingControllerProviderPassesProviderToRootWireframe
{
    id rootWireframe = self.rootWireframeMock;
    id<CPSViewControllerProvider> provider = OCMProtocolMock(@protocol(CPSViewControllerProvider));
    
    OCMExpect([rootWireframe setContentControllerProvider:provider]);
    
    [self.contentWireframe setContentControllerProvider:provider];
    
    OCMVerifyAll(rootWireframe);
}

- (void)testAdvancingCurrentProviderPassesMessageToMenuWireframe
{
    id menuWireframe = self.menuWireframeMock;
    
    OCMExpect([menuWireframe selectNextMenuItem]);
    
    [self.contentWireframe advanceCurrentContentProvider];
    
    OCMVerifyAll(menuWireframe);
}

@end
