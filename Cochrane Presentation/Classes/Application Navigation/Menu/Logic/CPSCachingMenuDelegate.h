//
//  CPSCachingMenuDelegate.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/11.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSMenuItem.h"
#import "CPSViewControllerMenuItem.h"

@class CPSRootWireframe;

/**
 *  Concrete implementation of the CPSMenuDelegate which caches view controllers.
 *  Supports CPSMenuItem and CPSViewControllerMenuItem
 */

@interface CPSCachingMenuDelegate : NSObject <CPSMenuItemDelegate, CPSViewControllerMenuItemDelegate>

- (instancetype)initWithRootWireframe:(CPSRootWireframe *)rootWireframe;

@end
