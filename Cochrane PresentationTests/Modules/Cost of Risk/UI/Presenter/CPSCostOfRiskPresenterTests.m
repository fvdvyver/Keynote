//
//  CPSCostOfRiskPresenterTests.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/24.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "CPSCostOfRiskPresenter.h"

#import "CPSBaseWireframe.h"

@interface CPSCostOfRiskPresenterTests : XCTestCase

@property (nonatomic, strong) CPSCostOfRiskPresenter * presenter;

@property (nonatomic, strong) CPSBaseWireframe * wireframeMock;
@property (nonatomic, strong) id<CPSCostOfRiskInteractorInput> interactorMock;
@property (nonatomic, strong) id<CPSCostOfRiskView> userInterfaceMock;

@end

@implementation CPSCostOfRiskPresenterTests

- (void)setUp
{
    [super setUp];
    
    id wireframe = OCMClassMock([CPSBaseWireframe class]);
    id interactor = OCMProtocolMock(@protocol(CPSCostOfRiskInteractorInput));
    id userInterface = OCMProtocolMock(@protocol(CPSCostOfRiskView));
    
    CPSCostOfRiskPresenter *presenter = [CPSCostOfRiskPresenter new];
    
    presenter.wireframe = wireframe;
    presenter.interactor = interactor;
    presenter.userInterface = userInterface;
    
    self.wireframeMock = wireframe;
    self.interactorMock = interactor;
    self.presenter = presenter;
    self.userInterfaceMock = userInterface;
}

- (void)tearDown
{
    self.presenter = nil;
    self.wireframeMock = nil;
    self.interactorMock = nil;
    self.userInterfaceMock = nil;
    
    [super tearDown];
}

- (void)testPresenterReloadsDataWhenResettingState
{
    id<CPSCostOfRiskView> userInterface = self.userInterfaceMock;
    
    OCMExpect([userInterface reloadData]);
    
    [self.presenter resetState];
    
    OCMVerifyAll((id)userInterface);
}

- (void)testPresenterAddsCellWhenItemAdded
{
    id<CPSCostOfRiskView> userInterface = self.userInterfaceMock;
    
    OCMExpect([userInterface addRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]);
    
    [self.presenter addItem:@"item"];
    
    OCMVerifyAll((id)userInterface);
}

- (void)testReceivingSingleTapAdvancesInteractorInput
{
    id<CPSCostOfRiskInteractorInput> interactor = self.interactorMock;
    
    OCMExpect([interactor advanceCurrentItem]);
    
    [self.presenter handleSingleTap];
    
    OCMVerifyAll((id)interactor);
}

- (void)testReceivingDoubleTapAdvancesWireframe
{
    CPSBaseWireframe *wireframe = self.wireframeMock;
    
    OCMExpect([wireframe advanceCurrentContentProvider]);
    
    [self.presenter handleDoubleTap];
    
    OCMVerifyAll((id)wireframe);
}

@end
