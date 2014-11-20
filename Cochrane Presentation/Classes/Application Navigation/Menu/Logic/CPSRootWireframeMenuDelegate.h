//
//  CPSRootWireframeMenuDelegate.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/20.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSMenuItem.h"
#import "CPSViewControllerMenuItem.h"

@class CPSRootWireframe;

@interface CPSRootWireframeMenuDelegate : NSObject <CPSMenuItemDelegate, CPSViewControllerMenuItemDelegate>

- (instancetype)initWithRootWireframe:(CPSRootWireframe *)rootWireframe;

@end
