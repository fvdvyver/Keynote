//
//  CPSImagePagerPresenter.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/14.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSImagePagerPresenter.h"

#import "MCFilePathImageLoader.h"

@implementation CPSImagePagerPresenter

@synthesize wireframe = _wireframe;

- (void)updateView
{
    [self.interactor requestImagePagerData];
}

- (void)viewTapped
{
    // nop
}

- (void)setTitle:(NSString *)title
{
    [self.userInterface setTitle:[title uppercaseString]];
}

- (void)setInitialImageIndex:(NSUInteger)index
{
    [self.userInterface setImageIndex:index];
}

- (void)setImageResources:(NSArray *)imageResources
{
    [self.userInterface setImageLoaders:[self imageLoadersForImageResources:imageResources]];
}

- (NSArray *)imageLoadersForImageResources:(NSArray *)imageResources
{
    return [MCFilePathImageLoader loadersWithFilePaths:imageResources];
}

@end
