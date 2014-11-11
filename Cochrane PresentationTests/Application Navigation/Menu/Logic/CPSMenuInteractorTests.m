//
//  CPSMenuInteractorTests.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/11.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "CPSMenuInteractor.h"

@interface CPSMenuInteractorTests : XCTestCase

@property (nonatomic, strong) CPSMenuInteractor * menuInteractor;
@property (nonatomic, strong) id<CPSMenuItemDelegate> menuDelegate;
@property (nonatomic, strong) id<CPSMenuInteractorOutput> output;

@end

@implementation CPSMenuInteractorTests

- (void)setUp
{
    [super setUp];
    
    CPSMenuInteractor *menuInteractor = [CPSMenuInteractor new];
    id<CPSMenuInteractorOutput> output = OCMProtocolMock(@protocol(CPSMenuInteractorOutput));
    id<CPSMenuItemDelegate> menuDelegate = OCMProtocolMock(@protocol(CPSMenuItemDelegate));
    
    menuInteractor.output = output;
    
    self.menuInteractor = menuInteractor;
    self.menuInteractor.menuDelegate = menuDelegate;
    self.menuDelegate = menuDelegate;
    self.output = output;
}

- (void)tearDown
{
    self.menuInteractor = nil;
    self.menuDelegate = nil;
    self.output = nil;
    
    [super tearDown];
}

- (void)testInteractorSendsDataToOutput
{
    NSArray *menuItems = @[];
    id output = self.output;
    
    // make sure output is updated when setting menu items
    [self.menuInteractor setMenuItems:menuItems];
    OCMVerify([output setMenuItems:menuItems]);
    
    // make sure output is updated when requesting update
    OCMExpect([output setMenuItems:menuItems]);
    [self.menuInteractor requestOutputDataUpdate];
    OCMVerifyAll(output);
}

- (void)testSettingMenuItemsResetsSelectedMenuItem
{
    id output = self.output;
    NSArray *menuItems = @[];
    
    [self.menuInteractor setMenuItems:menuItems];
    OCMVerify([output setSelectedMenuItem:nil]);
}

- (void)testInteractorUpdatesView
{
    id output = self.output;
    id selectedItem = [CPSMenuItem new];
    
    self.menuInteractor.selectedMenuItem = selectedItem;
    
    [self.menuInteractor updateOutput];
    OCMVerify([output setSelectedMenuItem:selectedItem]);
}

- (void)testSelectingMenuItemUpdatesState
{
    CPSMenuItem *menuItem = [CPSMenuItem new];
    id delegate = self.menuDelegate;
    id output = self.output;
    
    self.menuInteractor.menuItems = @[ menuItem ];
    
    [self.menuInteractor selectMenuItem:menuItem];
    
    XCTAssertEqualObjects(menuItem, self.menuInteractor.selectedMenuItem);
    OCMVerify([menuItem invokeAction:delegate]);
    OCMVerify([output setSelectedMenuItem:menuItem]);
}

@end
