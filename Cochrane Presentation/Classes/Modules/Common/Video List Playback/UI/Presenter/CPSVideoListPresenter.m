//
//  CPSVideoListPresenter.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/27.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSVideoListPresenter.h"

@interface CPSVideoListPresenter ()

- (NSURL *)introVideoFileURL;

@end

@implementation CPSVideoListPresenter

@synthesize wireframe = _wireframe;

- (NSURL *)introVideoFileURL
{
    NSString *filename = self.introVideoFilename;
    NSString *resourceName = [filename stringByDeletingPathExtension];
    NSString *pathExtension = [filename pathExtension];

    return [[NSBundle mainBundle] URLForResource:resourceName withExtension:pathExtension];
}

- (void)updateView
{    
    NSURL *url = [self introVideoFileURL];
    
    typeof(self) __weak weakself = self;
    [self.userInterface setUserInteractionEnabled:NO];
    [self.userInterface playBackgroundVideoAtURL:url withCompletion:^
    {
        [weakself introVideoPlaybackCompleted];
    }];
}

- (void)playVideoAtPath:(NSString *)path
{
    NSURL *url = [NSURL fileURLWithPath:path];
    [self.userInterface playContentVideoAtURL:url];
}

- (void)introVideoPlaybackCompleted
{
    [self.userInterface setUserInteractionEnabled:YES];
}

@end
