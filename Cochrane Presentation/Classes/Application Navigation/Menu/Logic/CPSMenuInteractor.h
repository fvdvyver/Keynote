//
//  CPSMenuInteractor.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/10.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSMenuItem.h"

@interface CPSMenuInteractor : NSObject

@property (nonatomic, strong) NSArray * menuItems;
@property (nonatomic, strong) id<CPSMenuItemDelegate> menuDelegate;

// This should not invoke the items action, nor should it notify the delegate
- (void)selectMenuItem:(CPSMenuItem *)item;

@end
