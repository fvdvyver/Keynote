//
//  MCRevealViewTransformer.m
//  MCiOSControls
//
//  Created by Rayman Rosevear on 2014/09/04.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "MCRevealViewTransformer.h"

#define SLIDE_ANIMATION_DRAG_FACTOR 1.0f / 4.0f

CGFloat mc_roundTo(CGFloat value, CGFloat roundTo)
{
    CGFloat inverseRoundTo = 1.0f / roundTo;
    return roundf(value * inverseRoundTo) * roundTo;
}

@interface MCBlockRevealViewTransformer ()
@property (nonatomic, copy) MCViewTransformerBlock transformBlock;
@end

@implementation MCRevealViewTransformer

- (instancetype)initWithPosition:(MCRevealControllerViewPosition)position
{
    if (self = [super init])
    {
        _position = position;
    }
    return self;
}

- (void)transformView:(UIView *)containerView
       forTranslation:(CGFloat)translation
           presenting:(BOOL)isPresenting
         inController:(MCRevealController *)revealController
{
    // No need to do anything for the left controller
    if (self.position == MCRevealControllerViewPositionRight)
    {
        CGFloat rightMaxWidth = [revealController rightViewMaxWidth];
        
        // We should be using the width of the front view container here instead of the width of self.view
        // But there is a bug on devices with non-retina screens, where the width of the front view container
        // is not always the same as the width of self.view (it is sometimes 1 point wider)
        CGFloat rightViewOffset = MAX(0.0f, CGRectGetWidth(revealController.view.bounds) - rightMaxWidth);
        containerView.frame = CGRectOffset(containerView.bounds, rightViewOffset, 0.0f);
    }
}

@end

@implementation MCBlockRevealViewTransformer

- (instancetype)initWithPosition:(MCRevealControllerViewPosition)position TransformerBlock:(MCViewTransformerBlock)transformBlock
{
    if (self = [super initWithPosition:position])
    {
        _transformBlock = transformBlock;
    }
    return self;
}

- (void)transformView:(UIView *)containerView
       forTranslation:(CGFloat)translation
           presenting:(BOOL)isPresenting
         inController:(MCRevealController *)revealController
{
    self.transformBlock(containerView, translation, isPresenting, revealController);
}

@end

@implementation MCFrontOverdrawViewTransformer

- (void)transformView:(UIView *)containerView
       forTranslation:(CGFloat)translation
           presenting:(BOOL)isPresenting
         inController:(MCRevealController *)revealController
{
    CGFloat frontContainerFrameMinX = 0.0f;
    
    CGFloat leftMinWidth = [revealController leftViewMinWidth];
    CGFloat leftMaxWidth = [revealController leftViewMaxWidth];
    CGFloat leftOverdrawMaxWidth = leftMinWidth + (leftMaxWidth - leftMinWidth) * 2.0f;
    
    CGFloat rightMinWidth = [revealController rightViewMinWidth];
    CGFloat rightMaxWidth = [revealController rightViewMaxWidth];
    CGFloat rightOverdrawMaxWidth = rightMinWidth + (rightMaxWidth - rightMinWidth) * 2.0f;
    
    // Constraining the translation to overdraw region here lets the front container always
    // move over the full overdraw distance (without this, it may stop before the edge of
    // the overdraw region if delta moves translation outside the region)
    translation = floorf(MAX(MIN(leftOverdrawMaxWidth, translation), -rightOverdrawMaxWidth));
    
    BOOL isPositiveTranslation = (translation > frontContainerFrameMinX);
    BOOL positiveTranslationDoesNotExceedMinWidth = (translation <= frontContainerFrameMinX + leftMinWidth);
    BOOL positiveTranslationDoesNotExceedMaxWidth = (translation <= frontContainerFrameMinX + leftOverdrawMaxWidth);
    
    BOOL isNegativeTranslation = (translation < frontContainerFrameMinX);
    BOOL negativeTranslationDoesNotExceedMinWidth = (translation >= frontContainerFrameMinX - rightMinWidth);
    BOOL negativeTranslationDoesNotExceedMaxWidth = (translation >= frontContainerFrameMinX - rightOverdrawMaxWidth);
    
    BOOL isLegalNormalTranslation = ([revealController hasLeftViewController] && isPositiveTranslation && positiveTranslationDoesNotExceedMinWidth)
    || ([revealController hasRightViewController] && isNegativeTranslation && negativeTranslationDoesNotExceedMinWidth);
    
    BOOL isLegalOverdrawTranslation = ([revealController hasLeftViewController] && isPositiveTranslation && positiveTranslationDoesNotExceedMaxWidth)
    || ([revealController hasRightViewController] && isNegativeTranslation && negativeTranslationDoesNotExceedMaxWidth);
    
    BOOL isLegalTranslation = isLegalNormalTranslation || isLegalOverdrawTranslation;
    if (isLegalTranslation == NO)
    {
        translation = 0.0f;
    }

    BOOL isOverdrawing = (!isLegalNormalTranslation && isLegalOverdrawTranslation);
    CGFloat overdrawDistance = 0.0f;
    
    if (isOverdrawing)
    {
        if (isPositiveTranslation)
        {
            overdrawDistance = translation - leftMinWidth;
        }
        else
        {
            overdrawDistance = translation + rightMinWidth;
        }
    }
    
    // In presentation mode, the translation should not be bound by the overdraw translation scaling
    if (!isPresenting)
    {
        translation -= overdrawDistance / 2.0f;
    }
    containerView.frame = CGRectOffset(containerView.bounds, translation, 0.0f);
}

@end

@implementation MCSlideRevealViewTransformer

- (void)transformView:(UIView *)containerView
       forTranslation:(CGFloat)translation
           presenting:(BOOL)isPresenting
         inController:(MCRevealController *)revealController
{
    CGFloat containerTranslation = 0.0f;
    if (self.position == MCRevealControllerViewPositionRight)
    {
        containerTranslation = [self rightTranslationForFrontTranslation:translation inController:revealController];
    }
    else
    {
        containerTranslation = [self leftTranslationForFrontTranslation:translation inController:revealController];
    }
    containerView.frame = CGRectOffset(containerView.bounds, containerTranslation, 0.0f);
}

- (CGFloat)leftTranslationForFrontTranslation:(CGFloat)frontViewTranslation inController:(MCRevealController *)revealController
{
    CGFloat leftMinWidth = [revealController leftViewMinWidth];
    
    CGFloat slideTranslation = MIN(leftMinWidth, frontViewTranslation);
    CGFloat containerTranslation = (-leftMinWidth + slideTranslation) / SLIDE_ANIMATION_DRAG_FACTOR;
    // For retina screens, round to the nearest 0.5. For normal screens, round to the nearest 1.0
    CGFloat leftViewTranslation = mc_roundTo(containerTranslation, 1.0f / [[UIScreen mainScreen] scale]);
    
    return leftViewTranslation;
}

- (CGFloat)rightTranslationForFrontTranslation:(CGFloat)frontViewTranslation inController:(MCRevealController *)revealController
{
    CGFloat rightMinWidth = [revealController rightViewMinWidth];
    CGFloat rightMaxWidth = [revealController rightViewMaxWidth];
    
    // We should be using the width of the front view container here instead of the width of self.view
    // But there is a bug on devices with non-retina screens, where the width of the front view container
    // is not always the same as the width of self.view (it is sometimes 1 point wider)
    CGFloat rightViewOffset = MAX(0.0f, CGRectGetWidth(revealController.view.bounds) - rightMaxWidth);
    
    CGFloat slideTranslation = MAX(-rightMinWidth, frontViewTranslation);
    CGFloat containerTranslation = rightViewOffset + (rightMinWidth + slideTranslation) / SLIDE_ANIMATION_DRAG_FACTOR;
    // For retina screens, round to the nearest 0.5. For normal screens, round to the nearest 1.0
    CGFloat rightViewTranslation = mc_roundTo(containerTranslation, 1.0f / [[UIScreen mainScreen] scale]);
    
    return rightViewTranslation;
}

@end
