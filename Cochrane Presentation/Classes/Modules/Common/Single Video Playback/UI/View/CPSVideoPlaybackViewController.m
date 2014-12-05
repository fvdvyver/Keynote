//
//  CPSVideoPlaybackViewController.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/21.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>

#import "CPSVideoPlaybackViewController.h"
#import "MPMoviePlayerController+CPSAdditions.h"

@interface CPSVideoPlaybackViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) MPMoviePlayerController *videoController;

- (void)setupGestureRecognizer;
- (void)viewDoubleTapped:(UIGestureRecognizer *)gestureRecognizer;

- (void)playbackDidFinish;

@end

@implementation CPSVideoPlaybackViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.eventHandler updateView];
    [self setupGestureRecognizer];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:self.videoController];
    [self.videoController stop];
}

- (void)setupGestureRecognizer
{
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(viewDoubleTapped:)];
    recognizer.numberOfTapsRequired = 2;
    recognizer.delegate = self;
    
    [self.view addGestureRecognizer:recognizer];
}

- (void)viewDoubleTapped:(UIGestureRecognizer *)gestureRecognizer
{
    [self.eventHandler viewDoubleTapped];
}

- (void)playVideoAtURL:(NSURL *)videoURL
{
    MPMoviePlayerController *videoController = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
    
    // Set the control style to none initially so that the user has to tap first to show the controls
    [videoController setControlStyleHidingInitially:MPMovieControlStyleFullscreen];
    videoController.repeatMode = MPMovieRepeatModeNone;
    
    [UIView performWithoutAnimation:^
    {
        UIView *videoView = [videoController view];
        videoView.frame = self.view.bounds;
        videoView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self.view addSubview:videoView];
        [self.view sendSubviewToBack:videoView];
    }];
    
    self.videoController = videoController;
    [self.videoController play];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playbackDidFinish)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:videoController];
}

- (void)playbackDidFinish
{
    [self.eventHandler videoPlaybackFinished];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
