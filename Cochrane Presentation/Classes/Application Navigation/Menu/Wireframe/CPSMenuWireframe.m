//
//  CPSMenuWireframe.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/13.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSMenuWireframe.h"

#import "CPSMenuItem.h"

#import "CPSMenuInteractor.h"
#import "CPSMenuPresenter.h"
#import "CPSMenuTableViewController.h"

@interface CPSMenuWireframe ()

@property (nonatomic, strong) CPSMenuInteractor *          menuInteractor;
@property (nonatomic, strong) CPSMenuTableViewController * menuViewController;

- (void)configureWithMenuItems:(NSArray *)menuItems delegate:(id<CPSMenuItemDelegate>)menuItemDelegate;

@end

@implementation CPSMenuWireframe

- (instancetype)initWithMenuItems:(NSArray *)menuItems delegate:(id<CPSMenuItemDelegate>)menuItemDelegate
{
    if (self = [super init])
    {
        [self configureWithMenuItems:menuItems delegate:menuItemDelegate];
    }
    return self;
}

- (void)configureWithMenuItems:(NSArray *)menuItems delegate:(id<CPSMenuItemDelegate>)menuItemDelegate
{
    CPSMenuInteractor *interactor = [CPSMenuInteractor new];
    CPSMenuPresenter *menuPresenter = [CPSMenuPresenter new];
    CPSMenuTableViewController *menuViewController = [CPSMenuTableViewController new];
    
    interactor.menuItems = menuItems;
    interactor.menuDelegate = menuItemDelegate;
    interactor.output = menuPresenter;
    
    menuPresenter.input = interactor;
    menuPresenter.userInterface = menuViewController;
    
    menuViewController.eventHandler = menuPresenter;
    
    self.menuInteractor = interactor;
    self.menuViewController = menuViewController;
}

- (UIViewController *)contentViewController
{
    return self.menuViewController;
}

@end
