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

- (void)testViewControllerItemInstantiatesCorrectViewController
{
    NSString *identifier = @"view controller x";
    
    id storyboard = OCMClassMock([UIStoryboard class]);
    CPSViewControllerMenuItem *menuItem = [[CPSViewControllerMenuItem alloc] initWithTitle:nil
                                                                                      icon:nil
                                                                  viewControllerIdentifier:identifier
                                                                              inStoryboard:storyboard];
    
    [menuItem contentViewController];
    
    OCMVerify([storyboard instantiateViewControllerWithIdentifier:identifier]);
}

@end
