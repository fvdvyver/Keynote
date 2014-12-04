//
//  CPSLoadingViewController.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/04.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSLoadingViewController.h"

#import <MediaPlayer/MediaPlayer.h>

@interface CPSLoadingViewController ()

- (void)loadBackgroundVideo;

@end

@implementation CPSLoadingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadBackgroundVideo];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.backgroundVideoController play];
}

- (void)loadBackgroundVideo
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"animated_background" withExtension:@"mp4"];
    MPMoviePlayerController *backgroundVideoController = [[MPMoviePlayerController alloc] initWithContentURL:url];
    backgroundVideoController.controlStyle = MPMovieControlStyleNone;
    backgroundVideoController.repeatMode = MPMovieRepeatModeOne;
    
    [UIView performWithoutAnimation:^
    {
        UIView *videoView = [backgroundVideoController view];
        videoView.frame = self.view.bounds;
        videoView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self.view addSubview:videoView];
        [self.view sendSubviewToBack:videoView];
    }];
    
    self.backgroundVideoController = backgroundVideoController;
}

@end
