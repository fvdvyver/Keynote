//
//  CPSRevealRootPresenterTests.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/10.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "CPSRevealRootPresenter.h"

@interface CPSRevealRootPresenterTests : XCTestCase

@property (nonatomic, strong) CPSRevealRootPresenter *presenter;
@property (nonatomic, strong) MCRevealController *revealController;

@end

@implementation CPSRevealRootPresenterTests

- (void)setUp
{
    [super setUp];
    
    MCRevealController *revealController = OCMClassMock([MCRevealController class]);
    CPSRevealRootPresenter *presenter = [CPSRevealRootPresenter new];
    
    presenter.revealController = revealController;
    
    self.revealController = revealController;
    self.presenter = presenter;
}

- (void)tearDown
{
    self.presenter = nil;
    self.revealController = nil;
    
    [super tearDown];
}

- (void)testSettingMenuViewControllerUpdatesRevealControllerLeftView
{
    UIViewController *viewController = [UIViewController new];
    [self.presenter setMenuViewController:viewController];
    
    MCRevealController *revealController = self.revealController;
    OCMVerify([revealController setLeftViewController:viewController]);
}

- (void)testSettingContentControllerUpdatesRevealControllerFrontView
{
    UIViewController *viewController = [UIViewController new];
    [self.presenter setContentViewController:viewController];
    
    MCRevealController *revealController = self.revealController;
    OCMVerify([revealController setFrontViewController:viewController]);
}

@end
