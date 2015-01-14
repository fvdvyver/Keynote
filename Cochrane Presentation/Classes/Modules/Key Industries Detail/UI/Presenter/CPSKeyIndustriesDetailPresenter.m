//
//  CPSKeyIndustriesDetailPresenter.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/28.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSKeyIndustriesDetailPresenter.h"

#import "MCNamedImageLoader.h"

@implementation CPSKeyIndustriesDetailPresenter

- (void)viewTapped
{
    [self.wireframe showMainViewController];
}

- (NSArray *)imageLoadersForImageResources:(NSArray *)imageResources
{
    return [MCNamedImageLoader loadersWithImageNames:imageResources];
}

@end
