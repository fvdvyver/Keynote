//
//  UIViewController+MCPagerIndexAdditions.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/10.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "UIViewController+MCPagerIndexAdditions.h"

#import <objc/runtime.h>

@implementation UIViewController (MCPagerIndexAdditions)

static void * const kMCPagerIndexAssociationKey = (void *) &kMCPagerIndexAssociationKey;

- (void)setMc_pagerIndex:(NSInteger)pagerIndex
{
    objc_setAssociatedObject(self, kMCPagerIndexAssociationKey, @(pagerIndex), OBJC_ASSOCIATION_RETAIN);
}

- (NSInteger)mc_pagerIndex
{
    return [objc_getAssociatedObject(self, kMCPagerIndexAssociationKey) integerValue];
}

@end
