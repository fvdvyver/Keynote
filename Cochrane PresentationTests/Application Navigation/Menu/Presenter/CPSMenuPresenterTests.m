//
//  CPSMenuPresenterTests.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/12.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "CPSMenuPresenter.h"
#import "CPSMenuItem.h"

@interface CPSMenuPresenterTests : XCTestCase

@property (nonatomic, strong) CPSMenuPresenter *presenter;

@property (nonatomic, strong) id<CPSMenuInteractorInput> inputMock;
@property (nonatomic, strong) id<CPSMenuViewInterface> userInterfaceMock;

@end

@implementation CPSMenuPresenterTests

- (void)setUp
{
    [super setUp];
    
    id input = OCMProtocolMock(@protocol(CPSMenuInteractorInput));
    id userInterface = OCMProtocolMock(@protocol(CPSMenuViewInterface));
    
    CPSMenuPresenter *presenter = [CPSMenuPresenter new];
    presenter.input = input;
    presenter.userInterface = userInterface;
    
    self.presenter = presenter;
    self.inputMock = input;
    self.userInterfaceMock = userInterface;
}

- (void)tearDown
{
    self.presenter = nil;
    self.inputMock = nil;
    self.userInterfaceMock = nil;
    
    [super tearDown];
}

- (void)testPresenterUpdatesViewDatasource
{
    id<CPSMenuViewInterface> userInterface = self.userInterfaceMock;
    
    [self.presenter setMenuItems:@[]];
    
    OCMVerify([userInterface setTableViewDatasource:[OCMArg checkWithBlock:^BOOL(id obj)
    {
        return [obj conformsToProtocol:@protocol(UITableViewDataSource)];
    }]]);
}

- (void)testPresenterUpdatesViewDelegate
{
    id<CPSMenuViewInterface> userInterface = self.userInterfaceMock;
    
    [self.presenter setMenuItems:@[]];
    
    OCMVerify([userInterface setTableViewDelegate:[OCMArg checkWithBlock:^BOOL(id obj)
    {
        return [obj conformsToProtocol:@protocol(UITableViewDelegate)];
    }]]);
}

- (void)testPresenterUpdatesInputWhenItemSelected
{
    id menuItem = OCMClassMock([CPSMenuItem class]);
    id userInterface = self.userInterfaceMock;
    id input = self.inputMock;
    
    // Record the delegate that is set, so we can invoke a method on it later
    __block id<UITableViewDelegate> delegate = nil;
    OCMStub([userInterface setTableViewDelegate:[OCMArg checkWithBlock:^BOOL(id obj)
    {
        delegate = obj;
        return YES;
    }]]);
    
    [self.presenter setMenuItems:@[ menuItem ]];
    XCTAssertNotNil(delegate, @"The UI must have a table view delegate at this point");
    
    [delegate tableView:nil didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    OCMVerify([input selectMenuItem:menuItem]);
}

- (void)testPresenterUpdatesViewSelection
{
    id menuItem = OCMClassMock([CPSMenuItem class]);
    id<CPSMenuViewInterface> userInterface = self.userInterfaceMock;
    
    [self.presenter setMenuItems:@[ OCMClassMock([CPSMenuItem class]), menuItem ]];
    
    [self.presenter setSelectedMenuItem:menuItem];
    
    OCMVerify([userInterface setSelectedIndexPath:[OCMArg checkWithBlock:^BOOL(NSIndexPath *path)
    {
        return path.row == 1;
    }]]);
}

- (void)testPresenterRequestsDatasourceUpdateFromInput
{
    id<CPSMenuInteractorInput> input = self.inputMock;
    
    [self.presenter updateDatasource];
    
    OCMVerify([input requestOutputDataUpdate]);
}

- (void)testPresenterRequestsSelectionUpdateFromInput
{
    id<CPSMenuInteractorInput> input = self.inputMock;
    
    [self.presenter updateSelection];
    
    OCMVerify([input updateOutput]);
}

@end
