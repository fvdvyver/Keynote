//
//  CPSVideoListViewController.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/27.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSVideoListViewController.h"

#import <MediaPlayer/MediaPlayer.h>

@interface CPSVideoListViewController ()

@property (nonatomic, strong) MPMoviePlayerController * contentVideoController;
@property (nonatomic, strong) MPMoviePlayerController * backgroundVideoController;

@property (nonatomic, copy) dispatch_block_t backgroundVideoCompletionBlock;

- (MPMoviePlayerController *)configureNewMovieControllerWithURL:(NSURL*)contentURL inContainer:(UIView *)containerView;

@end

@implementation CPSVideoListViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.eventHandler updateView];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.contentVideoController stop];
}

- (NSString *)cellReuseIdentifier
{
    return @"video_list_cell";
}

- (void)setUserInteractionEnabled:(BOOL)enabled
{
    self.view.userInteractionEnabled = enabled;
}

- (void)setTableViewDatasource:(id<UITableViewDataSource>)datasource
{
    [self.tableView setDataSource:datasource];
}

- (void)setTableViewDelegate:(id<UITableViewDelegate>)delegate
{
    [self.tableView setDelegate:delegate];
}

- (void)playContentVideoAtURL:(NSURL *)url
{
    MPMoviePlayerController *controller = [self configureNewMovieControllerWithURL:url
                                                                       inContainer:self.contentVideoContainerView];
    if (self.contentVideoShowsControls)
    {
        controller.controlStyle = MPMovieControlStyleEmbedded;
    }
    
    self.contentVideoController = controller;
    [self.contentVideoController play];
}

- (void)playBackgroundVideoAtURL:(NSURL *)url withCompletion:(dispatch_block_t)completion
{
    if (self.backgroundVideoController != nil)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:MPMoviePlayerPlaybackDidFinishNotification
                                                      object:self.backgroundVideoController];
    }
    
    self.contentView.alpha = 0.0;
    [self removeSubviewsFromBackgroundVideoContainerView];
    
    MPMoviePlayerController *videoController = [self configureNewMovieControllerWithURL:url
                                                                            inContainer:self.backgroundVideoContainerView];
    
    self.backgroundVideoController = videoController;
    [self.backgroundVideoController play];
    
    self.backgroundVideoCompletionBlock = completion;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(backgroundVideoPlaybackDidFinish)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:videoController];
}

- (MPMoviePlayerController *)configureNewMovieControllerWithURL:(NSURL*)contentURL inContainer:(UIView *)containerView
{
    MPMoviePlayerController *videoController = [[MPMoviePlayerController alloc] initWithContentURL:contentURL];
    videoController.controlStyle = MPMovieControlStyleNone;
    videoController.repeatMode = MPMovieRepeatModeNone;
    videoController.scalingMode = MPMovieScalingModeNone;
    
    [UIView performWithoutAnimation:^
    {
        UIView *videoView = [videoController view];
        videoView.frame = containerView.bounds;
        videoView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        videoView.userInteractionEnabled = NO;
        
        [containerView addSubview:videoView];
    }];
    
    return videoController;
}

- (void)backgroundVideoPlaybackDidFinish
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:self.backgroundVideoController];
    
    UIView *background = [self.backgroundVideoContainerView snapshotViewAfterScreenUpdates:NO];
    [self removeSubviewsFromBackgroundVideoContainerView];
    
    [self.backgroundVideoContainerView addSubview:background];
    
    [UIView animateWithDuration:1.0 animations:^
    {
        self.contentView.alpha = 1.0;
    }
    completion:^(BOOL finished)
    {
        [self removeSubviewsFromBackgroundVideoContainerView];
    }];
    
    if (self.backgroundVideoCompletionBlock != nil)
    {
        self.backgroundVideoCompletionBlock();
    }
}

- (void)removeSubviewsFromBackgroundVideoContainerView
{
    for (UIView *subview in self.backgroundVideoContainerView.subviews)
    {
        [subview removeFromSuperview];
    }
}

@end
