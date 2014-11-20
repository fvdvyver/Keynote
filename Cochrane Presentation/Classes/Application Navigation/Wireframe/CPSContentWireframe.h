//
//  CPSContentWireframe.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/18.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSViewControllerProvider.h"

@protocol CPSContentWireframe <NSObject>

- (void)setContentControllerProvider:(id<CPSViewControllerProvider>)contentControllerProvider;
- (void)advanceCurrentContentProvider;

@end

@protocol CPSSubContentWireframe <NSObject>

- (void)setParentContentWireframe:(id<CPSContentWireframe>)parentWireframe;
- (id<CPSContentWireframe>)parentContentWireframe;

- (void)advanceCurrentContentProvider;

@end
