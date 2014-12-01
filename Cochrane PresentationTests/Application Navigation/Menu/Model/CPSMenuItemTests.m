//
//  CPSMenuItemTests.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/10.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "CPSMenuItem.h"
#import "CPSViewControllerMenuItem.h"

@interface CPSMenuItemTests : XCTestCase

@property (nonatomic, strong) id<CPSMenuItemDelegate> menuDelegate;

@end

@implementation CPSMenuItemTests

- (void)setUp
{
    [super setUp];
    
    id delegate = OCMProtocolMock(@protocol(CPSViewControllerMenuItemDelegate));
    self.menuDelegate = delegate;
}

- (void)tearDown
{
    self.menuDelegate = nil;
    [super tearDown];
}

- (void)testMenuItemDelegateMethodCalled
{
    id menuDelegate = self.menuDelegate;
    
    CPSMenuItem *menuItem = [CPSMenuItem new];
    [menuItem invokeAction:menuDelegate];
    
    OCMVerify([menuDelegate menuItemSelected:menuItem]);
}

- (void)testViewControllerMenuItemDelegateMethodCalled
{
    id menuDelegate = self.menuDelegate;
    
    CPSViewControllerMenuItem *menuItem = [CPSViewControllerMenuItem new];
    [menuItem invokeAction:menuDelegate];
    
    OCMVerify([menuDelegate viewControllerMenuItemSelected:menuItem]);
}

- (void)testViewControllerMenuItemEquality
{
    CPSViewControllerMenuItem *item1 = [[CPSViewControllerMenuItem alloc] initWithIdentifier:@"1"
                                                                                       title:@"title"
                                                                                   icon:[UIImage new]
                                                                 viewControllerProvider:OCMProtocolMock(@protocol(CPSViewControllerProvider))];
    CPSViewControllerMenuItem *item2 = [[CPSViewControllerMenuItem alloc] initWithIdentifier:@"2"
                                                                                       title:item1.title
                                                                                   icon:item1.iconImage
                                                                 viewControllerProvider:item1.viewControllerProvider];
    CPSViewControllerMenuItem *item3 = [[CPSViewControllerMenuItem alloc] initWithIdentifier:@"1"
                                                                                       title:@"title"
                                                                                   icon:[UIImage new]
                                                                 viewControllerProvider:OCMProtocolMock(@protocol(CPSViewControllerProvider))];
    
    XCTAssertEqualObjects(item1, item1);
    XCTAssertEqualObjects(item1, item2);
    XCTAssertNotEqualObjects(item1, item3);
}

- (void)testViewControllerMenuItemHash
{
    CPSViewControllerMenuItem *item1 = [[CPSViewControllerMenuItem alloc] initWithIdentifier:@"1"
                                                                                       title:@"title"
                                                                                        icon:[UIImage new]
                                                                      viewControllerProvider:OCMProtocolMock(@protocol(CPSViewControllerProvider))];
    CPSViewControllerMenuItem *item2 = [[CPSViewControllerMenuItem alloc] initWithIdentifier:@"1"
                                                                                       title:item1.title
                                                                                        icon:item1.iconImage
                                                                      viewControllerProvider:item1.viewControllerProvider];
    CPSViewControllerMenuItem *item3 = [[CPSViewControllerMenuItem alloc] initWithIdentifier:@"1"
                                                                                       title:@"title"
                                                                                        icon:[UIImage new]
                                                                      viewControllerProvider:OCMProtocolMock(@protocol(CPSViewControllerProvider))];
    
    XCTAssertEqual([item1 hash], [item1 hash]);
    XCTAssertEqual([item1 hash], [item2 hash]);
    XCTAssertNotEqual([item1 hash], [item3 hash]);
}

@end
