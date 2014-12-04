//
//  CPSProductDetailPresenter.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/03.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSProductDetailPresenter.h"

#import "CPSProductRangeWireframe.h"

@interface CPSProductDetailPresenter ()

- (void)playVideo;

@end

@implementation CPSProductDetailPresenter

@synthesize interactor = _interactor;

- (void)updateView
{
    [self.userInterface setTitle:self.title];
    [self playVideo];
}

- (void)viewTapped
{
    [self.wireframe showMainViewController];
}

- (void)videoPlaybackFinished
{
    [self playVideo];
}

- (void)playVideo
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:self.videoName withExtension:nil];
    [self.userInterface playVideoAtURL:url];
}

@end
