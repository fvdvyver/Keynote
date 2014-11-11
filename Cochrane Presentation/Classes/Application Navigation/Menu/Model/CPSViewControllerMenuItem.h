//
//  CPSViewControllerMenuItem.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/10.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSMenuItem.h"
#import "CPSViewControllerProvider.h"

/**
 *  This menu item provides access to a view controller through the CPSViewControllerProvider protocol.
 *
 *  It adopts the NSCopying protocol so that instances can be used as keys in a dictionary. Two instances are considered equal if they have equal titles, and the icon and viewControllerProvider references are equal
 */
@interface CPSViewControllerMenuItem : CPSMenuItem <NSCopying>

- (instancetype)initWithTitle:(NSString *)title
                         icon:(UIImage *)icon
       viewControllerProvider:(id<CPSViewControllerProvider>)viewControllerProvider;

- (id<CPSViewControllerProvider>)viewControllerProvider;

- (BOOL)isEqualToMenuItem:(CPSViewControllerMenuItem *)otherItem;

@end

@protocol CPSViewControllerMenuItemDelegate <CPSMenuItemDelegate>

- (BOOL)viewControllerMenuItemSelected:(CPSViewControllerMenuItem *)menuItem;

@end
