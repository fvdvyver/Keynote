//
//  MCRevealViewTransformer.h
//  MCiOSControls
//
//  Created by Rayman Rosevear on 2014/09/04.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MCRevealController.h"

typedef NS_ENUM(NSInteger, MCRevealControllerViewPosition)
{
    MCRevealControllerViewPositionLeft,
    MCRevealControllerViewPositionRight
};

extern CGFloat mc_roundTo(CGFloat value, CGFloat roundTo);

/**
 *  Use an instance of this class to transform the left or right view of a reveal controller
 *  as it animates out
 */
@interface MCRevealViewTransformer : NSObject

@property (nonatomic, assign) MCRevealControllerViewPosition position;

- (instancetype)initWithPosition:(MCRevealControllerViewPosition)position;

// The default implementation will keep the view static in the correct position during the animations
- (void)transformView:(UIView *)containerView
       forTranslation:(CGFloat)translation
           presenting:(BOOL)isPresenting
         inController:(MCRevealController *)revealController;

@end

typedef void(^MCViewTransformerBlock)(UIView *containerView, CGFloat translation, BOOL isPresenting, MCRevealController *controller);

@interface MCBlockRevealViewTransformer : MCRevealViewTransformer

- (instancetype)initWithPosition:(MCRevealControllerViewPosition)position TransformerBlock:(MCViewTransformerBlock)transformBlock;

@end

@interface MCFrontOverdrawViewTransformer : MCRevealViewTransformer
@end

@interface MCSlideRevealViewTransformer : MCRevealViewTransformer
@end
