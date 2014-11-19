//
//  CPSRootContentWireframe.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/19.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSContentWireframe.h"

#import "CPSRootWireframe.h"
#import "CPSMenuWireframe.h"

/**
 *  This object serves as a root content wireframe, and as such has no parent. When the content controller provider is set, this is passed on to the root wireframe. Advancing the current selection informs the menu wireframe to select the next menu item
 */
@interface CPSRootContentWireframe : NSObject <CPSContentWireframe>

@property (nonatomic, strong) CPSRootWireframe * rootWireframe;
@property (nonatomic, strong) CPSMenuWireframe * menuWireframe;

@end
