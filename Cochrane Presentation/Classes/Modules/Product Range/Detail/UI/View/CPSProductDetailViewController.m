//
//  CPSProductDetailViewController.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/03.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSProductDetailViewController.h"

#import <AVFoundation/AVFoundation.h>

@interface CPSProductDetailViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) AVPlayer * videoPlayer;

- (void)setupGestureRecognizer;
- (void)viewTapped:(UIGestureRecognizer *)gestureRecognizer;

- (AVAsset*)assetCompositionForLoopingVideo:(NSURL *)videoURL;

- (void)playbackDidFinish;

@end

@implementation CPSProductDetailViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.titleLabel.text = nil;
    
    [self.eventHandler updateView];
    [self setupGestureRecognizer];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AVPlayerItemDidPlayToEndTimeNotification
                                                  object:self.self.videoPlayer.currentItem];
    [self.videoPlayer pause];
}

- (void)setupGestureRecognizer
{
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(viewTapped:)];
    recognizer.delegate = self;
    [self.view addGestureRecognizer:recognizer];
}

- (void)viewTapped:(UIGestureRecognizer *)gestureRecognizer
{
    [self.eventHandler viewTapped];
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

- (AVAsset*)assetCompositionForLoopingVideo:(NSURL *)videoURL
{
    int loopCount = 200;
    
    AVMutableComposition *composition = [[AVMutableComposition alloc] init];
    AVURLAsset* sourceAsset = [AVURLAsset URLAssetWithURL:videoURL options:nil];
    
    CMTimeRange editRange = CMTimeRangeMake(kCMTimeZero, CMTimeMake(sourceAsset.duration.value, sourceAsset.duration.timescale));
    NSError *editError;
    
    BOOL result = [composition insertTimeRange:editRange ofAsset:sourceAsset atTime:composition.duration error:&editError];
    if (result)
    {
        // 1 and 50 are pretty magical. I have no idea why it works, but they prevent a black flash when the video loops
        CMTime duration = CMTimeSubtract(editRange.duration, CMTimeMake(1, 50));
        CMTime time = duration;
        for (int i = 0; i < loopCount; ++i)
        {
            [composition insertTimeRange:editRange ofAsset:sourceAsset atTime:time error:&editError];
            time = CMTimeAdd(time, duration);
        }
    }
    
    return composition;
}

- (void)playVideoAtURL:(NSURL *)videoURL
{
    AVAsset *composition = [self assetCompositionForLoopingVideo:videoURL];
    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:composition];
    AVPlayer *videoPlayer = [AVPlayer playerWithPlayerItem:playerItem];
    AVPlayerLayer *videoLayer = [AVPlayerLayer playerLayerWithPlayer:videoPlayer];
    
    [videoPlayer setActionAtItemEnd:AVPlayerActionAtItemEndPause];
    
    [self.videoContainerView.layer addSublayer:videoLayer];
    videoLayer.frame = self.videoContainerView.bounds;
    videoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playbackDidFinish)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:playerItem];
    
    [videoPlayer play];
    self.videoPlayer = videoPlayer;
}

- (void)restartVideo
{
    [self.videoPlayer seekToTime:kCMTimeZero];
    [self.videoPlayer play];
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
