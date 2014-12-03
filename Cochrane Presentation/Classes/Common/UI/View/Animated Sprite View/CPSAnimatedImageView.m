//
//  CPSAnimatedImageView.m
//  AtlasDemo
//
//  Created by Rayman Rosevear on 2014/12/02.
//  Copyright (c) 2014 Charcoal Design. All rights reserved.
//

#import "CPSAnimatedImageView.h"

#import "LSImageMap.h"
#import "CPSImageViewAnimator.h"

@interface LSImageView (Private)

@property (nonatomic, strong) CALayer *spriteLayer;

@end

@implementation CPSAnimatedImageView

- (void)didMoveToWindow
{
    [super didMoveToWindow];
    
    if (self.window == nil)
    {
        [self.animator pauseImageView:self];
    }
    else
    {
        [self.animator animateImageView:self];
    }
}

- (void)setSpriteImageMap:(LSImageMap *)spriteImageMap
{
    _spriteImageMap = spriteImageMap;
    
    // normalize the current index to make sure it is valid, and also make sure the correct image is displayed
    self.currentSpriteIndex = self.currentSpriteIndex;
}

- (void)setCurrentSpriteIndex:(NSInteger )currentSpriteIndex
{
    NSInteger imageCount = self.spriteImageMap.imageCount;
    _currentSpriteIndex = currentSpriteIndex % imageCount;
    if (imageCount > 0)
    {
        self.image = self.spriteImageMap[self.currentSpriteIndex];
    }
}

- (void)setShouldAnimate:(BOOL)shouldAnimate
{
    _shouldAnimate = shouldAnimate;
    if (!self.shouldAnimate)
    {
        self.animator = nil;
    }
    else
    {
        [self.animator animateImageView:self];
    }
}

- (void)setAnimator:(CPSImageViewAnimator *)animator
{
    _shouldAnimate = YES;
    [self.animator removeImageView:self];
    
    _animator = animator;
    if (self.window != nil)
    {
        [self.animator animateImageView:self];
    }
}

@end
