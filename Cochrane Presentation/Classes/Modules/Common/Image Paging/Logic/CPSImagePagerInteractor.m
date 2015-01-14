//
//  CPSImagePagerInteractor.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/14.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSImagePagerInteractor.h"

@implementation CPSImagePagerInteractor

@synthesize wireframe = _wireframe;

- (void)requestImagePagerData
{
    [self.presenter setTitle:self.title ?: @""];
    [self.presenter setInitialImageIndex:self.initialImageIndex];
    [self.presenter setImageResources:self.imageResources];
}

@end
