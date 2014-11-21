//
//  CPSVideoPlayerPresenter.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/21.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSVideoPlayerPresenter.h"

#import "CPSBaseWireframe.h"

@implementation CPSVideoPlayerPresenter

@synthesize wireframe = _wireframe;

- (void)playVideoAtPath:(NSString *)videoPath
{
    NSURL *url = [NSURL fileURLWithPath:videoPath];
    [self.userInterface playVideoAtURL:url];
}

- (void)updateView
{
    [self.interactor requestVideoFilepath];
}

- (void)viewDoubleTapped
{
    [self.wireframe advanceCurrentContentProvider];
}

- (void)videoPlaybackFinished
{
    [self.wireframe advanceCurrentContentProvider];
}

@end
