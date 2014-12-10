//
//  CPSMvidTableViewCell.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/10.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSMvidTableViewCell.h"

#import "AVAnimatorMedia.h"
#import "AV7zAppResourceLoader.h"
#import "AVFileUtil.h"
#import "AVMvidFrameDecoder.h"

#import "CPSMvidView.h"

@interface CPSMvidTableViewCell ()

- (void)applyDefaultMvidCellAttributes;
- (void)setupMvidCell;

- (void)resetAnimatorView;
- (void)animatorMediaReadyToAnimateNotification;

@end

@implementation CPSMvidTableViewCell

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self applyDefaultMvidCellAttributes];
    [self setupMvidCell];
}

- (void)applyDefaultMvidCellAttributes
{
    UIView *backgroundView = [UIView new];
    backgroundView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.2];
    
    self.backgroundColor = [UIColor clearColor];
    self.selectedBackgroundView = backgroundView;
    self.textLabel.text = nil;
}

- (void)setupMvidCell
{
    if (self.animatorView == nil)
    {
        AVAnimatorView *animatorView = [CPSMvidView new];
        self.animatorView = animatorView;
    }
    
    [self.contentView addSubview:self.animatorView];
}

- (void)resetAnimatorView
{
    [self.animatorView stopAnimating];
    [self.animatorView attachMedia:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AVAnimatorPreparedToAnimateNotification
                                                  object:nil];
}

- (void)animatorMediaReadyToAnimateNotification
{
    [self setNeedsLayout];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.textLabel.text = nil;
    [self resetAnimatorView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if ([self.animatorView.media isReadyToAnimate])
    {
        CGPoint center = CGPointMake(CGRectGetWidth(self.contentView.bounds) / 2.0 + self.animatorOffset.width,
                                     CGRectGetHeight(self.contentView.bounds) / 2.0 + self.animatorOffset.height);
        
        [self.animatorView sizeToFit];
        self.animatorView.center = center;
    }
}

- (void)playMvidFileWithName:(NSString *)fileName
{
    [self resetAnimatorView];
    
    AVAnimatorMedia *media = [AVAnimatorMedia aVAnimatorMedia];
    media.animatorRepeatCount = INFINITY;
    
    AVAppResourceLoader *resLoader = [AVAppResourceLoader aVAppResourceLoader];
    resLoader.movieFilename = fileName;
    
    media.resourceLoader = resLoader;
    
    AVMvidFrameDecoder *frameDecoder = [AVMvidFrameDecoder aVMvidFrameDecoder];
    media.frameDecoder = frameDecoder;
    media.animatorFrameDuration = 1.0 / 25.0;
    
    [media prepareToAnimate];
    [self.animatorView attachMedia:media];
    
    [media startAnimator];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(animatorMediaReadyToAnimateNotification)
                                                 name:AVAnimatorPreparedToAnimateNotification
                                               object:media];
}

@end
