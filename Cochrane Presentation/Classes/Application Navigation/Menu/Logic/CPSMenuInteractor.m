//
//  CPSMenuInteractor.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/10.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSMenuInteractor.h"

@implementation CPSMenuInteractor

// **********************************************************************************
#pragma mark - Accessors/Mutators
// **********************************************************************************

- (void)setMenuItems:(NSArray *)menuItems
{
    _menuItems = menuItems;
    
    self.selectedMenuItem = nil;
    [self requestOutputDataUpdate];
    [self updateOutput];
}

// **********************************************************************************
#pragma mark - Public Implementation
// **********************************************************************************

- (void)selectMenuItem:(CPSMenuItem *)item
{
    BOOL selectItem = [item invokeAction:self.menuDelegate];
    if (selectItem)
    {
        self.selectedMenuItem = item;
    }

    [self updateOutput];
}

// Select the first item with the given identifier
- (void)selectMenuItemWithIdentifier:(NSString *)identifier
{
    for (CPSMenuItem *item in self.menuItems)
    {
        if ([item.identifier isEqualToString:identifier])
        {
            [self selectMenuItem:item];
            break;
        }
    }
}

// **********************************************************************************
#pragma mark - CPSMenuInteractorInput Protocol Methods
// **********************************************************************************

- (void)requestOutputDataUpdate
{
    [self.output setMenuItems:self.menuItems];
}

- (void)updateOutput
{
    [self.output setSelectedMenuItem:self.selectedMenuItem];
}

@end
