//
//  CPSMenuItem.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/10.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CPSMenuItemDelegate;

@interface CPSMenuItem : NSObject

@property (nonatomic, strong) UIImage *  iconImage;
@property (nonatomic, strong) NSString * title;

- (instancetype)initWithTitle:(NSString *)title icon:(UIImage *)icon;

/**
 *  This simulates double dispatch to ensure the correct method is called.
 *  The delegates result is returned.
 */
- (BOOL)invokeAction:(id<CPSMenuItemDelegate>)delegate;

@end

@protocol CPSMenuItemDelegate <NSObject>

/**
 *  This is an informal protocol. The method called will be based on the name of the menu item class.
 *  The namespace of the class will be removed, the method will have camel hump notation, and end in
 *  "MenuItemSelected:", e.g:
 *
 *  - CPSMenuItem will call     -menuItemSelected:(CPSMenuItem *)
 *  - XXTypeMenuItem will call  -typeMenuItemSelected:(XXTypeMenuItem *)
 *  - XXTypeOtherName will call -typeOtherNameMenuItemSelected:(XXTypeOtherName *)
 *
 *  Return YES if the menu item retains selection, or NO if the item should not be selected
 */

// This is the default handler that gets called
- (BOOL)menuItemSelected:(CPSMenuItem *)menuItem;

@end
