//
//  CPSMenuWireframe.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/13.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CPSViewControllerProvider.h"

@protocol CPSMenuItemDelegate;

@interface CPSMenuWireframe : NSObject <CPSViewControllerProvider>

- (instancetype)initWithMenuItems:(NSArray *)menuItems delegate:(id<CPSMenuItemDelegate>)menuItemDelegate;

@end
