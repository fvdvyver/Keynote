//
//  CPSImageViewAnimator.m
//  AtlasDemo
//
//  Created by Rayman Rosevear on 2014/12/02.
//  Copyright (c) 2014 Charcoal Design. All rights reserved.
//

#import "CPSImageViewAnimator.h"

#import "CPSAnimatedImageView.h"

@interface CPSImageViewAnimator ()

@property (nonatomic, strong) CADisplayLink * displayLink;
@property (nonatomic, assign) BOOL isAnimating;

@property (nonatomic, strong) NSMutableSet * animatingImageViews;

- (void)updateDisplayLinkState;
- (void)displayLinkFire:(CADisplayLink *)displayLink;

@end

@implementation CPSImageViewAnimator

+ (instancetype)sharedAnimator
{
    static CPSImageViewAnimator *animator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        animator = [[self class] new];
    });
    
    return animator;
}

- (instancetype)init
{
    if (self = [super init])
    {
        _framerate = 30;
        
        _animatingImageViews = [NSMutableSet set];
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkFire:)];
        _displayLink.frameInterval = 60.0 / _framerate;
    }
    return self;
}

- (void)setFramerate:(CGFloat)framerate
{
    _framerate = framerate;
    self.displayLink.frameInterval = 60.0 / _framerate;
}

- (void)setEnabled:(BOOL)enabled
{
    _enabled = enabled;
    [self updateDisplayLinkState];
}

- (void)animateImageView:(CPSAnimatedImageView *)imageView
{
    if (imageView.animator != self)
    {
        imageView.animator = self;
    }
    if (imageView.window == nil)
    {
        [self.animatingImageViews removeObject:imageView];
    }
    else
    {
        [self.animatingImageViews addObject:imageView];
    }
    
    [self updateDisplayLinkState];
}

- (void)pauseImageView:(CPSAnimatedImageView *)imageView
{
    [self.animatingImageViews removeObject:imageView];
    [self updateDisplayLinkState];
}

- (void)removeImageView:(CPSAnimatedImageView *)imageView
{
    [self.animatingImageViews removeObject:imageView];
    [self updateDisplayLinkState];
}

- (void)removeAllImageViews
{
    [self.animatingImageViews removeAllObjects];
    [self updateDisplayLinkState];
}

- (BOOL)isImageViewAnimating:(CPSAnimatedImageView *)imageView
{
    return self.isAnimating && [self.animatingImageViews containsObject:imageView];
}

- (void)updateDisplayLinkState
{
    BOOL shouldRun = (self.animatingImageViews.count > 0 && self.enabled);
    if (shouldRun != self.isAnimating)
    {
        if (shouldRun)
        {
            [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        }
        else
        {
            [_displayLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        }
        self.isAnimating = shouldRun;
    }
}

- (void)displayLinkFire:(CADisplayLink *)displayLink
{
    [self updateDisplayLinkState];
    for (CPSAnimatedImageView *imageView in self.animatingImageViews)
    {
        ++imageView.currentSpriteIndex;
    }
}

@end
