//
//  CPSCostOfRiskViewController.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/24.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSCostOfRiskViewController.h"

#import <MediaPlayer/MediaPlayer.h>

#import "CPSCostOfRiskCell.h"
#import "UITableView+CPSBorderMaskStretchAdditions.h"

#import "MCDescendentViewGestureDelegate.h"

@interface CPSCostOfRiskViewController ()

@property (nonatomic, strong) MCDescendentViewGestureDelegate *tapGestureDelegate;

@property (nonatomic, strong) MPMoviePlayerController * contentVideoController;
@property (nonatomic, strong) MPMoviePlayerController * backgroundVideoController;

@property (nonatomic, copy) dispatch_block_t backgroundVideoCompletionBlock;

- (void)configureTableView;
- (void)configureGestureRecognisers;

- (void)handleSignleTap:(UITapGestureRecognizer *)gestureRecognizer;
- (void)handleDoubleTap:(UITapGestureRecognizer *)gestureRecognizer;

- (void)backgroundVideoPlaybackDidFinish;

- (void)removeSubviewsFromBackgroundVideoContainerView;

@end

@implementation CPSCostOfRiskViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)configureTableView
{
    self.tableView.dataSource = nil;
    self.tableView.delegate = nil;
    [self.tableView registerClass:[CPSCostOfRiskCell class]
           forCellReuseIdentifier:[self cellReuseIdentifier]];
    
    [self.tableView cps_configureTableViewInsetsForMask];
    [self.tableView cps_configureTableViewMask];
}

- (void)configureGestureRecognisers
{
    // This gesture recogniser will ensure that tapping on a tableview cell
    // will not cause the single tap gesture to fire
    self.tapGestureDelegate = [MCDescendentViewGestureDelegate new];
    self.tapGestureDelegate.baseView = self.tableView;
    self.tapGestureDelegate.allowTouchesOnBaseView = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSignleTap:)];
    singleTap.delegate = self.tapGestureDelegate;
    
    [self.view addGestureRecognizer:singleTap];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureTableView];
    [self configureGestureRecognisers];
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

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CALayer *maskLayer = self.tableView.layer.mask;
    CGRect maskFrame = maskLayer.frame;
    
    maskFrame.size.height = CGRectGetHeight(self.tableView.bounds);
    
    maskLayer.frame = maskFrame;
}

- (void)setTableViewDatasource:(id<UITableViewDataSource>)datasource
{
    [self.tableView setDataSource:datasource];
}

- (void)setTableViewDelegate:(id<UITableViewDelegate>)delegate
{
    [self.tableView setDelegate:delegate];
}

- (void)setUserInteractionEnabled:(BOOL)enabled
{
    self.view.userInteractionEnabled = enabled;
}

- (void)reloadData
{
    [self.tableView reloadData];
}

- (void)addRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView insertRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)selectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionBottom];
}

- (void)playContentVideoAtURL:(NSURL *)url
{
    MPMoviePlayerController *videoController = [[MPMoviePlayerController alloc] initWithContentURL:url];
    
    // Set the control style to none initially so that the user has to tap first to show the controls
    videoController.controlStyle = MPMovieControlStyleNone;
    videoController.repeatMode = MPMovieRepeatModeNone;
    videoController.scalingMode = MPMovieScalingModeNone;
    
    [UIView performWithoutAnimation:^
    {
        UIView *videoView = [videoController view];
        videoView.frame = self.contentVideoContainerView.bounds;
        videoView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        videoView.userInteractionEnabled = NO;
        
        [self.contentVideoContainerView addSubview:videoView];
    }];
    
    self.contentVideoController = videoController;
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
    
    MPMoviePlayerController *videoController = [[MPMoviePlayerController alloc] initWithContentURL:url];
    
    // Set the control style to none initially so that the user has to tap first to show the controls
    videoController.controlStyle = MPMovieControlStyleNone;
    videoController.repeatMode = MPMovieRepeatModeNone;
    videoController.scalingMode = MPMovieScalingModeNone;
    
    [UIView performWithoutAnimation:^
    {
        UIView *videoView = [videoController view];
        videoView.frame = self.backgroundVideoContainerView.bounds;
        videoView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        videoView.userInteractionEnabled = NO;
        
        [self.backgroundVideoContainerView addSubview:videoView];
    }];
    
    self.backgroundVideoController = videoController;
    [self.backgroundVideoController play];
    
    self.backgroundVideoCompletionBlock = completion;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(backgroundVideoPlaybackDidFinish)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:videoController];
}

- (void)handleSignleTap:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.eventHandler handleSingleTap];
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.eventHandler handleDoubleTap];
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

- (NSString *)cellReuseIdentifier
{
    return @"cell";
}

@end
