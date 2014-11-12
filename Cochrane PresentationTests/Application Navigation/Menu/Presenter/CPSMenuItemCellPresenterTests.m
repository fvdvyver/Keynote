//
//  CPSMenuItemCellPresenterTests.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/12.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "CPSMenuItemCellPresenter.h"
#import "CPSMenuItem.h"

@interface CPSMenuItemCellPresenterTests : XCTestCase

@property (nonatomic, strong) CPSMenuItemCellPresenter * presenter;

@property (nonatomic, strong) CPSMenuItem * mockMenuItem;
@property (nonatomic, strong) id<CPSMenuItemCellInterface> mockCell;

@end

@implementation CPSMenuItemCellPresenterTests

- (void)setUp
{
    [super setUp];
    
    self.presenter = [CPSMenuItemCellPresenter new];

    self.mockMenuItem = OCMClassMock([CPSMenuItem class]);
    self.mockCell = OCMProtocolMock(@protocol(CPSMenuItemCellInterface));
}

- (void)tearDown
{
    self.presenter = nil;
    self.mockCell = nil;
    
    [super tearDown];
}

- (void)testPresenterSetsCellText
{
    id cell = self.mockCell;
    id menuItem = self.mockMenuItem;
    NSString *title = @"title text";
    
    OCMStub([menuItem title]).andReturn(title);
    
    [self.presenter configureCell:cell forItem:self.mockMenuItem atIndexPath:nil inTableView:nil];
    
    OCMVerify([cell setTitle:title]);
}

- (void)testPresenterSetsCellIcon
{
    id cell = self.mockCell;
    id menuItem = self.mockMenuItem;
    id icon = OCMClassMock([UIImage class]);
    
    OCMStub([menuItem iconImage]).andReturn(icon);
    
    [self.presenter configureCell:cell forItem:self.mockMenuItem atIndexPath:nil inTableView:nil];
    
    OCMVerify([cell setIcon:icon]);
}

@end
