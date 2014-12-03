//
//  CPSImageViewAnimator.h
//  AtlasDemo
//
//  Created by Rayman Rosevear on 2014/12/02.
//  Copyright (c) 2014 Charcoal Design. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CPSAnimatedImageView;

/**
 *  Instances of this class will maintain a display link, to make sure that the imageviews are animated at the specified frequency
 */
@interface CPSImageViewAnimator : NSObject

@property (nonatomic, assign) CGFloat framerate;
@property (nonatomic, assign) BOOL    enabled;

+ (instancetype)sharedAnimator;

- (void)animateImageView:(CPSAnimatedImageView *)imageView;
- (void)pauseImageView:(CPSAnimatedImageView *)imageView;
- (void)removeImageView:(CPSAnimatedImageView *)imageView;

- (void)removeAllImageViews;

- (BOOL)isImageViewAnimating:(CPSAnimatedImageView *)imageView;

@end
