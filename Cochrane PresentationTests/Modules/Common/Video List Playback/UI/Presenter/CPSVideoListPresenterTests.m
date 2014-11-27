//
//  CPSVideoListPresenterTests.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/27.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "CPSVideoListPresenter.h"

@interface CPSVideoListPresenterTests : XCTestCase

@property (nonatomic, strong) CPSVideoListPresenter * presenter;
@property (nonatomic, strong) id<CPSVideoListView> userInterfaceMock;

@end

@implementation CPSVideoListPresenterTests

- (void)setUp
{
    [super setUp];
    
    id userInterface = OCMProtocolMock(@protocol(CPSVideoListView));
    
    CPSVideoListPresenter *presenter = [CPSVideoListPresenter new];
    presenter.userInterface = userInterface;
    
    self.presenter = presenter;
    self.userInterfaceMock = userInterface;
}

- (void)tearDown
{
    self.presenter = nil;
    self.userInterfaceMock = nil;
    
    [super tearDown];
}

- (void)testPresenterPlaysVideoWhenRequested
{
    id<CPSVideoListView> userInterface = self.userInterfaceMock;
    
    NSString *path = @"file:///fake/path";
    NSURL *url = [NSURL fileURLWithPath:path];
    
    OCMExpect([userInterface playContentVideoAtURL:url]);
    
    [self.presenter playVideoAtPath:path];
    
    OCMVerifyAll((id)userInterface);
}

- (void)testPresenterPlaysBackgroundVideoWhenViewRequestsUpdate
{
    id<CPSVideoListView> userInterface = self.userInterfaceMock;
    
    OCMExpect([userInterface playBackgroundVideoAtURL:[OCMArg any] withCompletion:[OCMArg any]]);
    
    [self.presenter updateView];
    
    OCMVerifyAll((id)userInterface);
}

@end
