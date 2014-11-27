//
//  CPSCostOfRiskInteractorTests.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/24.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "CPSCostOfRiskInteractor.h"
#import "CPSCostOfRiskInteractorIO.h"

#import "CPSVideoListItem.h"

#import "CPSBaseWireframe.h"

@interface CPSCostOfRiskInteractorTests : XCTestCase

@property (nonatomic, strong) CPSCostOfRiskInteractor * interactor;

@property (nonatomic, strong) NSArray * videoItems;
@property (nonatomic, strong) CPSBaseWireframe * wireframeMock;
@property (nonatomic, strong) id<CPSCostOfRiskInteractorOutput> presenterMock;

@end

@implementation CPSCostOfRiskInteractorTests

- (void)setUp
{
    [super setUp];
    
    id wireframe = OCMClassMock([CPSBaseWireframe class]);
    id presenter = OCMStrictProtocolMock(@protocol(CPSCostOfRiskInteractorOutput));

    CPSVideoListItem *item1 = [CPSVideoListItem new];
    CPSVideoListItem *item2 = [CPSVideoListItem new];
    
    item1.titleText     = @"item 1";
    item1.videoFilename = @"viedo 1";
    item2.titleText     = @"item 2";
    item2.videoFilename = @"viedo 2";
    
    NSArray *items = @[ item1, item2 ];
    
    CPSCostOfRiskInteractor *interactor = [CPSCostOfRiskInteractor new];
    
    interactor.wireframe = wireframe;
    interactor.presenter = presenter;
    interactor.videoItems = items;
    
    self.interactor = interactor;
    self.videoItems = items;
    self.wireframeMock = wireframe;
    self.presenterMock = presenter;
}

- (void)tearDown
{
    self.interactor = nil;
    self.videoItems = nil;
    self.wireframeMock = nil;
    self.presenterMock = nil;
    
    [super tearDown];
}

- (void)testRequestingNextItemReturnsSequentialItems
{
    id<CPSCostOfRiskInteractorOutput> presenterMock = self.presenterMock;
    
    OCMExpect([presenterMock addItem:@"item 1"]);
    OCMExpect([presenterMock addItem:@"item 2"]);
    
    [self.interactor advanceCurrentItem];
    [self.interactor advanceCurrentItem];
    
    OCMVerifyAll((id)presenterMock);
}

- (void)testResettingStateCausesInteractorToReturnFirstItemWhenAdvancingAndResetsOutputState
{
    id<CPSCostOfRiskInteractorOutput> presenterMock = self.presenterMock;
    
    OCMExpect([presenterMock addItem:@"item 1"]);
    OCMExpect([presenterMock addItem:@"item 2"]);
    
    OCMExpect([presenterMock resetState]);
    
    OCMExpect([presenterMock addItem:@"item 1"]);
    
    [self.interactor advanceCurrentItem];
    [self.interactor advanceCurrentItem];
    [self.interactor resetState];
    [self.interactor advanceCurrentItem];
    
    OCMVerifyAll((id)presenterMock);
}

- (void)testInteractorAdvancesWireframesCurrentContentProviderWhenAllItemsShown
{
    // disable presenter mocks for this test
    self.interactor.presenter = nil;
    
    CPSBaseWireframe *wireframe = self.wireframeMock;
    
    OCMExpect([wireframe advanceCurrentContentProvider]);
    
    [self.interactor advanceCurrentItem];
    [self.interactor advanceCurrentItem];
    [self.interactor advanceCurrentItem];
    
    OCMVerifyAll((id)wireframe);
}

- (void)testInteractorDoesNotAdvancesWireframesCurrentContentProviderWhenAllItemsNotShown
{
    // Disable presenter mocks for this test
    self.interactor.presenter = nil;
    
    CPSBaseWireframe *wireframe = self.wireframeMock;
    
    [[(id)wireframe reject] advanceCurrentContentProvider];
    
    [self.interactor advanceCurrentItem];
    [self.interactor advanceCurrentItem];
    
    OCMVerifyAll((id)wireframe);
}

@end
