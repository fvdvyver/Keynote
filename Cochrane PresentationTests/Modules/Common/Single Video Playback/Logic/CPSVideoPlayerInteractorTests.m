//
//  CPSVideoPlayerInteractorTests.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/21.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "CPSVideoPlayerInteractor.h"

@interface CPSVideoPlayerInteractorTests : XCTestCase

@property (nonatomic, strong) CPSVideoPlayerInteractor * interactor;

@property (nonatomic, strong) NSString * videoFileName;
@property (nonatomic, strong) id<CPSVideoPlayerInteractorOutput> presenterMock;

@end

@implementation CPSVideoPlayerInteractorTests

- (void)setUp
{
    [super setUp];
    
    CPSVideoPlayerInteractor *interactor = [CPSVideoPlayerInteractor new];
    NSString *videoFileName = @"test_resource.txt";
    id<CPSVideoPlayerInteractorOutput> presenter = OCMProtocolMock(@protocol(CPSVideoPlayerInteractorOutput));
    
    interactor.videoName = videoFileName;
    interactor.presenter = presenter;
    
    self.interactor = interactor;
    self.videoFileName = videoFileName;
    self.presenterMock = presenter;
}

- (void)tearDown
{
    self.interactor = nil;
    self.videoFileName = nil;
    self.presenterMock = nil;
    
    [super tearDown];
}

- (void)testInteractorPassesFullPathOfVideoToPresenter
{
    id presenter = self.presenterMock;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test_resource" ofType:@"txt"];
    
    OCMExpect([presenter playVideoAtPath:path]);
    
    [self.interactor requestVideoFilepath];
    
    OCMVerifyAll(presenter);
}

@end
