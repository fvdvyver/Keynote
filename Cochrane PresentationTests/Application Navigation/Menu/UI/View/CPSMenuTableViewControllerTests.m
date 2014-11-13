//
//  CPSMenuTableViewControllerTests.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/12.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "CPSMenuTableViewController.h"

@interface CPSMenuTableViewControllerTests : XCTestCase

@property (nonatomic, strong) CPSMenuTableViewController * menuViewController;

@property (nonatomic, strong) CPSMenuTableViewController * menuViewControllerMock;
@property (nonatomic, strong) id<CPSMenuViewEventHandler>  eventHandlerMock;
@property (nonatomic, strong) UITableView * tableViewMock;

@end

@implementation CPSMenuTableViewControllerTests

- (void)setUp
{
    [super setUp];
    
    CPSMenuTableViewController *viewController = [CPSMenuTableViewController new];
    CPSMenuTableViewController *viewControllerMock = OCMPartialMock(viewController);
    id<CPSMenuViewEventHandler> eventHandlerMock = OCMProtocolMock(@protocol(CPSMenuViewEventHandler));
    UITableView *tableViewMock = OCMClassMock([UITableView class]);
    
    viewController.eventHandler = eventHandlerMock;
    OCMStub([viewControllerMock tableView]).andReturn(tableViewMock);
    
    self.menuViewController = viewController;
    self.menuViewControllerMock = viewControllerMock;
    self.eventHandlerMock = eventHandlerMock;
    self.tableViewMock = tableViewMock;
}

- (void)tearDown
{
    self.menuViewController = nil;
    self.menuViewControllerMock = nil;
    self.tableViewMock = nil;
    
    [super tearDown];
}

- (void)testViewControllerUpdatesTableViewSelectedIndexPath
{
    id tableViewMock = self.tableViewMock;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
    
    [[[tableViewMock expect] ignoringNonObjectArgs] selectRowAtIndexPath:indexPath animated:YES scrollPosition:0];
    
    [self.menuViewControllerMock setSelectedIndexPath:indexPath];
    
    OCMVerifyAll(tableViewMock);
}

- (void)testViewControllerUpdatesTableviewDatasource
{
    id tableViewMock = self.tableViewMock;
    
    [self.menuViewControllerMock setTableViewDatasource:OCMProtocolMock(@protocol(UITableViewDataSource))];
    
    OCMVerify([tableViewMock setDataSource:[OCMArg checkWithBlock:^BOOL(id obj)
    {
        return [obj conformsToProtocol:@protocol(UITableViewDataSource)];
    }]]);
}

- (void)testViewControllerUpdatesTableviewDelegate
{
    id tableViewMock = self.tableViewMock;
    
    [self.menuViewControllerMock setTableViewDelegate:OCMProtocolMock(@protocol(UITableViewDelegate))];
    
    OCMVerify([tableViewMock setDelegate:[OCMArg checkWithBlock:^BOOL(id obj)
    {
        NSLog(@"%@", obj);
        return [obj conformsToProtocol:@protocol(UITableViewDelegate)];
    }]]);
}

- (void)testViewControllerRequestsDatasourceOnViewWillAppear
{
    id<CPSMenuViewEventHandler> eventHandler = self.eventHandlerMock;
    
    [self.menuViewController viewWillAppear:NO];
    
    OCMVerify([eventHandler updateDatasource]);
}

- (void)testViewControllerDoesNotRequestDatasourceUnnecessarily
{
    id eventHandler = self.eventHandlerMock;
    id menuViewController = self.menuViewController;
    id tableView = self.tableViewMock;
    
    OCMStub([tableView dataSource]).andReturn(OCMProtocolMock(@protocol(UITableViewDataSource)));
    [[eventHandler reject] updateDatasource];
    
    [menuViewController viewWillAppear:NO];
    
    [eventHandler verify];
}

- (void)testViewControllerRequestsSelectionUpdateOnViewWillAppear
{
    id<CPSMenuViewEventHandler> eventHandler = self.eventHandlerMock;
    
    [self.menuViewController viewWillAppear:NO];
    
    OCMVerify([eventHandler updateSelection]);
}

- (void)testViewControllerRegistersAppropriateCellOnViewDidLoad
{
    id tableview = self.tableViewMock;
    NSString *cellReuseIdentifier = [self.menuViewController menuItemCellReuseIdentifier];
    
    [self.menuViewController viewDidLoad];
    
    OCMVerify([tableview registerClass:[OCMArg checkWithBlock:^BOOL(Class obj)
    {
        return [obj conformsToProtocol:@protocol(CPSMenuItemCellInterface)];
    }] forCellReuseIdentifier:cellReuseIdentifier]);
}

@end
