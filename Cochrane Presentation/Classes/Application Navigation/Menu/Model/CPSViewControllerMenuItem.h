//
//  CPSViewControllerMenuItem.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/10.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSMenuItem.h"
#import "CPSViewControllerProvider.h"

@interface CPSViewControllerMenuItem : CPSMenuItem <CPSViewControllerProvider>

- (instancetype)initWithTitle:(NSString *)title
                         icon:(UIImage *)icon
     viewControllerIdentifier:(NSString *)controllerIdentifier
                 inStoryboard:(UIStoryboard *)storyboard;

- (NSString *)viewControllerIdentifier;

@end

@protocol CPSViewControllerMenuItemDelegate <CPSMenuItemDelegate>

- (BOOL)viewControllerMenuItemSelected:(CPSViewControllerMenuItem *)menuItem;

@end
