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

- (instancetype)initWithStoryboardName:(NSString*)storyboardname
                             menuItems:(NSArray *)menuItems
                              delegate:(id<CPSMenuItemDelegate>)menuItemDelegate;

- (void)selectMenuItemAtIndex:(NSInteger)index;

@end
