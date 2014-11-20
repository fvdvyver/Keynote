//
//  CPSMenuItemLoader.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/20.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CPSContentWireframe;

/**
 *  This object provides an interface into loading and configuring menu items from a property list file
 */
@interface CPSMenuItemLoader : NSObject

+ (NSArray *)loadMenuItemsFromFile:(NSString *)filename;

+ (void)injectContentWireframe:(id<CPSContentWireframe>)contentWireframe asParentOfWireframe:(id)subwireframe;
+ (void)injectContentWireframe:(id<CPSContentWireframe>)contentWireframe asParentOfMenuItems:(NSArray *)menuItems;

@end
