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
#import "CPSCostOfRiskItem.h"
#import "CPSCostOfRiskInteractorIO.h"

#import "CPSBaseWireframe.h"

@interface CPSCostOfRiskInteractorTests : XCTestCase

@property (nonatomic, strong) CPSCostOfRiskInteractor * interactor;

@property (nonatomic, strong) NSArray * presentationItems;
@property (nonatomic, strong) CPSBaseWireframe * wireframeMock;
@property (nonatomic, strong) id<CPSCostOfRiskInteractorOutput> presenterMock;

@end

@implementation CPSCostOfRiskInteractorTests

- (void)setUp
{
    [super setUp];
    
    id wireframe = OCMClassMock([CPSBaseWireframe class]);
    id presenter = OCMStrictProtocolMock(@protocol(CPSCostOfRiskInteractorOutput));

    CPSCostOfRiskItem *item1 = [CPSCostOfRiskItem new];
    CPSCostOfRiskItem *item2 = [CPSCostOfRiskItem new];
    
    item1.titleText = @"item 1";
    item1.videoFile = @"viedo 1";
    item2.titleText = @"item 2";
    item2.videoFile = @"viedo 2";
    
    NSArray *items = @[ item1, item2 ];
    
    CPSCostOfRiskInteractor *interactor = [CPSCostOfRiskInteractor new];
    
    interactor.wireframe = wireframe;
    interactor.presenter = presenter;
    interactor.presentationItems = items;
    
    self.interactor = interactor;
    self.presentationItems = items;
    self.wireframeMock = wireframe;
    self.presenterMock = presenter;
}

- (void)tearDown
{
    self.interactor = nil;
    self.presentationItems = nil;
    self.wireframeMock = nil;
    self.presenterMock = nil;
    
    [super tearDown];
}

- (void)testRequestingNextItemReturnsSequentialItems
{
    id<CPSCostOfRiskInteractorOutput> presenterMock = self.presenterMock;
    
    OCMExpect([presenterMock addItem:@"item 1"]); OCMExpect([presenterMock playVideoAtPath:[OCMArg any]]);
    OCMExpect([presenterMock addItem:@"item 2"]); OCMExpect([presenterMock playVideoAtPath:[OCMArg any]]);
    
    [self.interactor advanceCurrentItem];
    [self.interactor advanceCurrentItem];
    
    OCMVerifyAll((id)presenterMock);
}

- (void)testResettingStateCausesInteractorToReturnFirstItemWhenAdvancingAndResetsOutputState
{
    id<CPSCostOfRiskInteractorOutput> presenterMock = self.presenterMock;
    
    OCMExpect([presenterMock addItem:@"item 1"]); OCMExpect([presenterMock playVideoAtPath:[OCMArg any]]);
    OCMExpect([presenterMock addItem:@"item 2"]); OCMExpect([presenterMock playVideoAtPath:[OCMArg any]]);
    
    OCMExpect([presenterMock resetState]);
    
    OCMExpect([presenterMock addItem:@"item 1"]); OCMExpect([presenterMock playVideoAtPath:[OCMArg any]]);
    
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

- (void)testInteractorPlaysVideoWhenItemIsSelected
{
    id<CPSCostOfRiskInteractorOutput> presenterMock = self.presenterMock;
    
    OCMExpect([presenterMock playVideoAtPath:[OCMArg any]]);
    
    [self.interactor itemSelectedAtIndex:0];
    
    OCMVerifyAll((id)presenterMock);
}

@end
