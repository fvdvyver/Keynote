//
//  CPSAnimatedImageView.h
//  AtlasDemo
//
//  Created by Rayman Rosevear on 2014/12/02.
//  Copyright (c) 2014 Charcoal Design. All rights reserved.
//

#import "LSImageView.h"

@class LSImageMap;
@class CPSImageViewAnimator;

/**
 *  This class will animate through the sprites in an image map sequentially
 */
@interface CPSAnimatedImageView : LSImageView

@property (nonatomic, assign) NSInteger    currentSpriteIndex;
@property (nonatomic, strong) LSImageMap * spriteImageMap;

// This will be reset to nil when shouldAnimate is set to NO
@property (nonatomic, weak)   CPSImageViewAnimator * animator;

/**
 *  This specifies whether the view should be animated or not when part of a CPSImageViewAnimator. 
 *  If this value is YES, the image view will not animate until added to an animator, and it will not animate while not part of a window
 */
@property (nonatomic, assign) BOOL shouldAnimate;

@end
