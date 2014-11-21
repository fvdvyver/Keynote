//
//  CPSVideoPlayerPresenterTests.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/21.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "CPSVideoPlayerPresenter.h"
#import "CPSBaseWireframe.h"

@interface CPSVideoPlayerPresenterTests : XCTestCase

@property (nonatomic, strong) CPSVideoPlayerPresenter * presenter;

@property (nonatomic, strong) CPSBaseWireframe * wireframeMock;
@property (nonatomic, strong) id<CPSVideoPlayerInteractorInput> interactorMock;
@property (nonatomic, strong) id<CPSVideoPlayerViewInterface>   userInterfaceMock;

@end

@implementation CPSVideoPlayerPresenterTests

- (void)setUp
{
    [super setUp];
    
    CPSVideoPlayerPresenter *presenter = [CPSVideoPlayerPresenter new];
    id wireframe = OCMClassMock([CPSBaseWireframe class]);
    id interactor = OCMProtocolMock(@protocol(CPSVideoPlayerInteractorInput));
    id interface = OCMProtocolMock(@protocol(CPSVideoPlayerViewInterface));
    
    presenter.wireframe = wireframe;
    presenter.userInterface = interface;
    presenter.interactor = interactor;
    
    self.presenter = presenter;
    self.wireframeMock = wireframe;
    self.interactorMock = interactor;
    self.userInterfaceMock = interface;
}

- (void)tearDown
{
    self.presenter = nil;
    self.interactorMock = nil;
    self.userInterfaceMock = nil;
    
    [super tearDown];
}

- (void)testPlayingVideoAtPathSendsURLToUserInterface
{
    id userInterface = self.userInterfaceMock;
    NSString *path = @"/fake/path";
    NSURL *url = [NSURL URLWithString:@"file:///fake/path"];
    
    OCMExpect([userInterface playVideoAtURL:url]);
    
    [self.presenter playVideoAtPath:path];
    
    OCMVerifyAll(userInterface);
}

- (void)testUpdatingViewRequestsVideoPathForPlayback
{
    id interactor = self.interactorMock;
    
    OCMExpect([interactor requestVideoFilepath]);
    
    [self.presenter updateView];
    
    OCMVerifyAll(interactor);
}

- (void)testPresenterAdvancesWireframeToNextContentOnViewDoubleTap
{
    id wireframe = self.wireframeMock;
    
    OCMExpect([wireframe advanceCurrentContentProvider]);
    
    [self.presenter viewDoubleTapped];
    
    OCMVerifyAll(wireframe);
}

- (void)testPresenterAdvancesWireframeToNextContentOnVideoPlaybackFinished
{
    id wireframe = self.wireframeMock;
    
    OCMExpect([wireframe advanceCurrentContentProvider]);
    
    [self.presenter videoPlaybackFinished];
    
    OCMVerifyAll(wireframe);
}

@end
