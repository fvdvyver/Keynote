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

@property (nonatomic, strong) NSString * storyboardName;

@property (nonatomic, strong) CPSMenuInteractor *          menuInteractor;
@property (nonatomic, strong) CPSMenuTableViewController * menuViewController;

- (void)configureWithMenuItems:(NSArray *)menuItems delegate:(id<CPSMenuItemDelegate>)menuItemDelegate;

- (UIStoryboard *)mainStoryboard;
- (CPSMenuTableViewController *)newMenuTableViewController;

@end

@implementation CPSMenuWireframe

// **********************************************************************************
#pragma mark - Object Life Cycle
// **********************************************************************************

- (instancetype)initWithStoryboardName:(NSString*)storyboardname
                             menuItems:(NSArray *)menuItems
                              delegate:(id<CPSMenuItemDelegate>)menuItemDelegate
{
    if (self = [super init])
    {
        _storyboardName = storyboardname;
        [self configureWithMenuItems:menuItems delegate:menuItemDelegate];
    }
    return self;
}

// **********************************************************************************
#pragma mark - Private Implementation
// **********************************************************************************

- (void)configureWithMenuItems:(NSArray *)menuItems delegate:(id<CPSMenuItemDelegate>)menuItemDelegate
{
    CPSMenuInteractor *interactor = [CPSMenuInteractor new];
    CPSMenuPresenter *menuPresenter = [CPSMenuPresenter new];
    CPSMenuTableViewController *menuViewController = [self newMenuTableViewController];
    
    interactor.menuItems = menuItems;
    interactor.menuDelegate = menuItemDelegate;
    interactor.output = menuPresenter;
    
    menuPresenter.input = interactor;
    menuPresenter.userInterface = menuViewController;
    
    menuViewController.eventHandler = menuPresenter;
    
    self.menuInteractor = interactor;
    self.menuViewController = menuViewController;
}

- (UIStoryboard *)mainStoryboard
{
    return [UIStoryboard storyboardWithName:self.storyboardName bundle:[NSBundle mainBundle]];
}

- (CPSMenuTableViewController *)newMenuTableViewController
{
    return [self.mainStoryboard instantiateViewControllerWithIdentifier:@"MenuTableViewController"];
}

// **********************************************************************************
#pragma mark - Public Interface
// **********************************************************************************

- (void)selectMenuItemAtIndex:(NSInteger)index
{
    CPSMenuItem *itemToSelect = self.menuInteractor.menuItems[index];
    [self.menuInteractor selectMenuItem:itemToSelect];
}

- (void)selectMenuItemWithIdentifier:(NSString *)identifier
{
    [self.menuInteractor selectMenuItemWithIdentifier:identifier];
}

- (void)selectNextMenuItem
{
    id selectedItem = self.menuInteractor.selectedMenuItem;
    NSUInteger currentIndex = [self.menuInteractor.menuItems indexOfObject:selectedItem];
    
    if (currentIndex < self.menuInteractor.menuItems.count - 1)
    {
        [self selectMenuItemAtIndex:currentIndex + 1];
    }
}

// **********************************************************************************
#pragma mark - CPSViewControllerProvider Implementation
// **********************************************************************************

- (UIViewController *)contentViewController
{
    return self.menuViewController;
}

@end
