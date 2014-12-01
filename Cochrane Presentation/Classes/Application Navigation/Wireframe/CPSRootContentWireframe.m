//
//  CPSRootContentWireframe.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/19.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSRootContentWireframe.h"

@implementation CPSRootContentWireframe

- (void)setContentControllerProvider:(id<CPSViewControllerProvider>)contentControllerProvider
{
    [self.rootWireframe setContentControllerProvider:contentControllerProvider];
}

- (void)setContentControllerProviderWithIdentifer:(NSString *)identifier
{
    [self.menuWireframe selectMenuItemWithIdentifier:identifier];
}

- (void)advanceCurrentContentProvider
{
    [self.menuWireframe selectNextMenuItem];
}

@end
