//
//  CPSViewControllerContentWireframeTests.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/18.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "CPSViewControllerContentWireframe.h"

@interface CPSViewControllerContentWireframeTests : XCTestCase

@property (nonatomic, strong) CPSViewControllerContentWireframe * wireframe;

@property (nonatomic, strong) id<CPSContentWireframe> parentWireframeMock;
@property (nonatomic, strong) NSArray * contentProviders;

@end

@implementation CPSViewControllerContentWireframeTests

- (void)setUp
{
    [super setUp];
    
    NSArray *contentProviders = @[
                                  OCMProtocolMock(@protocol(CPSViewControllerProvider)),
                                  OCMProtocolMock(@protocol(CPSViewControllerProvider)),
                                  OCMProtocolMock(@protocol(CPSViewControllerProvider))
                                  ];
    
    CPSViewControllerContentWireframe *wireframe = [CPSViewControllerContentWireframe new];
    CPSViewControllerContentWireframe *parentWireframe = OCMProtocolMock(@protocol(CPSContentWireframe));
    
    wireframe.parentContentWireframe = parentWireframe;
    wireframe.contentProviders = contentProviders;
    
    self.wireframe = wireframe;
    self.parentWireframeMock = parentWireframe;
    self.contentProviders = contentProviders;
}

- (void)tearDown
{
    self.wireframe = nil;
    self.parentWireframeMock = nil;
    self.contentProviders = nil;
    
    [super tearDown];
}

- (void)testWireframeResetsIndexWhenProvidersChange
{
    // First ensure the selected index is non zero
    [self.wireframe advanceCurrentContentProvider];
    
    self.wireframe.contentProviders = @[ OCMProtocolMock(@protocol(CPSViewControllerProvider)) ];
    
    XCTAssertNotEqual(self.wireframe.currentContentProviderIndex, 1, @"The current provider index should reset when the content providers change");
}

- (void)testWireframeIncrementsIndexWhenAdvancingProvider
{
    [self.wireframe advanceCurrentContentProvider];
    XCTAssertEqual(self.wireframe.currentContentProviderIndex, 1);
}

- (void)testWireframeCallsParentAdvanceMethodWhenAdvancingUnavailable
{
    id parentWireframe = OCMStrictProtocolMock(@protocol(CPSContentWireframe));
    self.wireframe.parentContentWireframe = parentWireframe;
    
    // Expect this once and only once
    OCMExpect([parentWireframe advanceCurrentContentProvider]);
    
    // Expect this twice and only twice
    OCMExpect([parentWireframe setContentControllerProvider:[OCMArg any]]);
    OCMExpect([parentWireframe setContentControllerProvider:[OCMArg any]]);
    
    [self.wireframe advanceCurrentContentProvider];
    [self.wireframe advanceCurrentContentProvider];
    [self.wireframe advanceCurrentContentProvider];
    
    OCMVerifyAll(parentWireframe);
}

- (void)testAdvancingSetsParentsContentProvider
{
    id parentWireframe = self.parentWireframeMock;
    id nextControllerProvider = self.contentProviders[self.wireframe.currentContentProviderIndex + 1];
    
    OCMExpect([parentWireframe setContentControllerProvider:nextControllerProvider]);
    
    [self.wireframe advanceCurrentContentProvider];
    
    OCMVerifyAll(parentWireframe);
}

- (void)testSettingContentProviderSetsParentsContentProvider
{
    id parentWireframe = self.parentWireframeMock;
    id provider = OCMProtocolMock(@protocol(CPSViewControllerProvider));
    
    OCMExpect([parentWireframe setContentControllerProvider:provider]);
    
    [self.wireframe setContentControllerProvider:provider];
    
    OCMVerifyAll(parentWireframe);
}

- (void)testCorrectViewControllerRetrieved
{
    // For this test, we advance the wireframe once, then make sure the second view controller is retrieved
    id controllerProvider = self.contentProviders[1];
    id expectedViewController = OCMClassMock([UIViewController class]);
    
    [self.wireframe advanceCurrentContentProvider];
    
    OCMExpect([controllerProvider contentViewController]).andReturn(expectedViewController);
    
    UIViewController *actualViewController = [self.wireframe contentViewController];
    
    OCMVerifyAll(controllerProvider);
    XCTAssertEqual(expectedViewController, actualViewController);
}

- (void)testCorrectViewControllerRetrievedWhenPreparingForNewContent
{
    // For this test, we advance the wireframe once, then make sure the first view controller is
    // retrieved after preparing for new content
    id controllerProvider = self.contentProviders[0];
    id expectedViewController = OCMClassMock([UIViewController class]);
    
    [self.wireframe advanceCurrentContentProvider];
    
    OCMExpect([controllerProvider contentViewController]).andReturn(expectedViewController);
    
    [self.wireframe prepareContentViewController];
    UIViewController *actualViewController = [self.wireframe contentViewController];
    
    OCMVerifyAll(controllerProvider);
    XCTAssertEqual(expectedViewController, actualViewController);
}

@end
