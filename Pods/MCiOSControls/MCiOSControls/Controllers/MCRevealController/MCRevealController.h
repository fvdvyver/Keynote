//
//  MCRevealController.h
//
//  Created by Rayman Rosevear on 2013/08/16. Heavily based
//	off the implementation of PKRevealController by
//	Philip Kluz (https://github.com/pkluz/PKRevealController)
//  Copyright (c) 2013 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+MCRevealController.h"
#import "MCSideViewController.h"

#ifndef IBInspectable
#define IBInspectable
#endif

@class MCRevealViewTransformer;

typedef NS_ENUM(NSUInteger, MCRevealControllerState)
{
    MCRevealControllerFocusesLeftViewController,
    MCRevealControllerFocusesRightViewController,
    MCRevealControllerFocusesFrontViewController,
    MCRevealControllerFocusesLeftViewControllerInPresentationMode,
    MCRevealControllerFocusesRightViewControllerInPresentationMode
};

typedef NS_OPTIONS(NSUInteger, MCRevealControllerType)
{
    MCRevealControllerTypeNone  = 0,
    MCRevealControllerTypeLeft  = 1 << 0,
    MCRevealControllerTypeRight = 1 << 1,
    MCRevealControllerTypeBoth = (MCRevealControllerTypeLeft | MCRevealControllerTypeRight)
};

#pragma mark - Notification Names

/**
 *	Names of the various notifications sent out. The animation durations and curves used
 *	can be queried via the animationDuration and animationCurve properties
 */
extern NSString * const MCRevealControllerWillEnterPresentationModeNotification;
extern NSString * const MCRevealControllerWillResignPresentationModeNotification;

#pragma mark - Options
/*
 * List of option keys that can be passed in the options dictionary.
 */

/*
 * Animation duration for automatic front view movement.
 *
 * @default 0.3sec
 * @value NSNumber containing an NSTimeInterval (double)
 */
extern NSString * const MCRevealControllerAnimationDurationKey;

/*
 * Animation curve for automatic front view movement.
 *
 * @default UIViewAnimationOptionCurveEaseInOut
 * @value NSNumber containing a UIViewAnimationCurve (NSUInteger)
 */
extern NSString * const MCRevealControllerAnimationCurveKey;

/*
 * The minimum swipe velocity to trigger front view movement even if the actual min-threshold wasn't reached.
 *
 * @default 0.0f
 * @value NSNumber containing CGFloat
 */
extern NSString * const MCRevealControllerQuickSwipeToggleVelocityKey;

/*
 * Determines whether front view interaction is disabled while presenting a side view.
 *
 * @default YES
 * @value NSNumber containing BOOL
 */
extern NSString * const MCRevealControllerDisablesFrontViewInteractionKey;

/*
 * Determines whether there's a UIPanGestureRecognizer placed over the entire view, enabling pan-based reveal.
 * The difference between this and MCRevealControllerRecognizesPanningOnFrontViewKey is the view the gesture
 * recognizer is placed on. Setting this to YES will disable panning on just the front view if it is enabled
 *
 * @default NO
 * @value NSNumber containing BOOL
 */
extern NSString * const MCRevealControllerRecognizesPanningOnViewKey;

/*
 * Determines whether there's a UIPanGestureRecognizer placed over the front view, enabling pan-based reveal.
 * The difference between this and MCRevealControllerRecognizesPanningOnViewKey is the view the gesture
 * recognizer is placed on. Setting this to YES will disable panning on full view if it is enabled
 *
 * @default YES
 * @value NSNumber containing BOOL
 */
extern NSString * const MCRevealControllerRecognizesPanningOnFrontViewKey;

/*
 * Determines whether there's a UITapGestureRecognizer placed over the entire front view, when presenting
 * one of the side views to enable snap-back-on-tap functionality.
 *
 * @default YES
 * @value NSNumber containing BOOL
 */
extern NSString * const MCRevealControllerRecognizesResetTapOnFrontViewKey;

typedef void(^MCDefaultCompletionHandler)(BOOL finished);
typedef void(^MCDefaultErrorHandler)(NSError *error);

@interface MCRevealController : UIViewController

#pragma mark - Properties
@property (nonatomic, strong, readonly) UIViewController *frontViewController;
@property (nonatomic, strong, readonly) UIViewController *leftViewController;
@property (nonatomic, strong, readonly) UIViewController *rightViewController;

@property (nonatomic, strong, readonly) UIPanGestureRecognizer *revealPanGestureRecognizer;
@property (nonatomic, strong, readonly) UITapGestureRecognizer *revealResetTapGestureRecognizer;

@property (nonatomic, assign, readonly) MCRevealControllerState state;
@property (nonatomic, assign, readonly) BOOL isPresentationModeActive;

@property (nonatomic, strong, readonly) NSDictionary *options;

@property (nonatomic, assign, readwrite) CGFloat animationDuration;
@property (nonatomic, assign, readwrite) UIViewAnimationOptions animationCurve;
@property (nonatomic, assign, readwrite) CGFloat quickSwipeVelocity;
@property (nonatomic, assign, readwrite) BOOL recognizesPanningOnFrontView;
@property (nonatomic, assign, readwrite) BOOL recognizesResetTapOnFrontView;
@property (nonatomic, assign, readwrite) IBInspectable BOOL disablesFrontViewInteraction;
@property (nonatomic, assign, readwrite) IBInspectable BOOL recognizesPanningOnView;

@property (nonatomic, strong, readwrite) IBOutlet MCRevealViewTransformer * frontViewTransformer;
@property (nonatomic, strong, readwrite) IBOutlet MCRevealViewTransformer * leftViewTransformer;
@property (nonatomic, strong, readwrite) IBOutlet MCRevealViewTransformer * rightViewTransformer;

@property (nonatomic, strong, readwrite) IBInspectable UIColor * frontViewShadowColor;
@property (nonatomic, assign, readwrite) IBInspectable CGFloat frontViewShadowOpacity;
@property (nonatomic, assign, readwrite) IBInspectable CGFloat frontViewShadowRadius;
@property (nonatomic, assign, readwrite) IBInspectable CGSize  frontViewShadowOffset;

#pragma mark - Methods

/**
 * Initializers. Left/right controllers can be added/exchanged/removed dynamically after initialization.
 */
+ (instancetype)revealControllerWithFrontViewController:(UIViewController *)frontViewController
                                     leftViewController:(UIViewController *)leftViewController
                                    rightViewController:(UIViewController *)rightViewController
                                                options:(NSDictionary *)options;

+ (instancetype)revealControllerWithFrontViewController:(UIViewController *)frontViewController
                                     leftViewController:(UIViewController *)leftViewController
                                                options:(NSDictionary *)options;

+ (instancetype)revealControllerWithFrontViewController:(UIViewController *)frontViewController
                                    rightViewController:(UIViewController *)rightViewController
                                                options:(NSDictionary *)options;

- (id)initWithFrontViewController:(UIViewController *)frontViewController
               leftViewController:(UIViewController *)leftViewController
              rightViewController:(UIViewController *)rightViewController
                          options:(NSDictionary *)options;

- (id)initWithFrontViewController:(UIViewController *)frontViewController
               leftViewController:(UIViewController *)leftViewController
                          options:(NSDictionary *)options;

- (id)initWithFrontViewController:(UIViewController *)frontViewController
              rightViewController:(UIViewController *)rightViewController
                          options:(NSDictionary *)options;

/**
 * Registers a `UIView` subclass that the touches should forward dragging through.
 *
 * When the user drags the front view to reveal the left or right views underneath, if the pan gesture is performed on an
 * instance of a class that has been registed as a touch forwarding class, the gesture is ignored. By default,
 * `UISlider` and `UISwitch` are registered as touch forwarding classes.
 *
 * @param touchForwardingClass The class that should not allow pan gestures through.
 */
- (void)registerTouchForwardingClass:(Class)touchForwardingClass;
- (void)unregisterTouchForwardingClass:(Class)touchForwardingClass;

/**
 * Shifts the front view to the position that's best suited to present the desired controller's view. (Animates by default)
 *
 * @param controller - This is either the left or the right view controller (if present - respectively).
 */
- (void)showViewController:(UIViewController *)controller;

/**
 * Shifts the front view to the position that's best suited to present the desired controller's view.
 *
 * @param controller - This is either the left or the right view controller (if present - respectively).
 * @param animated - Whether the frame adjustments should be animated or not.
 * @param completion - Executed on the main thread after the show animation is completed.
 */
- (void)showViewController:(UIViewController *)controller
                  animated:(BOOL)animated
                completion:(MCDefaultCompletionHandler)completion;

/**
 * Takes the currently active controller and enters presentation mode, thereby revealing the maximum width
 * of the view, which can be specified via the left/rightViewWidthRange properties.
 *
 * @param animated - Whether the frame adjustments should be animated or not.
 * @param completion - Executed on the main thread after the show animation is completed.
 */
- (void)enterPresentationModeAnimated:(BOOL)animated
                           completion:(MCDefaultCompletionHandler)completion;

/**
 * If active, this method will resign the presentation mode.
 * 
 * @param entirely - By passing YES for this parameter, not only will the presentation mode resign, but the entire
 *                        controller will go back to showing the front view only.
 * @param animated - Whether the frame adjustments should be animated or not.
 * @param completion - Executed on the main thread after the show animation is completed.
 */
- (void)resignPresentationModeEntirely:(BOOL)entirely
                              animated:(BOOL)animated
                            completion:(MCDefaultCompletionHandler)completion;

/**
 * Exchanges the current front view controller for a new one.
 *
 * @param frontViewController - The new front view controller.
 */
- (void)setFrontViewController:(UIViewController *)frontViewController;

/**
 * Exchanges the current front view controller for a new one.
 *
 * @param frontViewController - The new front view controller.
 * @param focus - Whether the front view controller's view animates back to its center position after it was set.
 * @param completion - Executed on the main thread after the show animation is completed.
 */
- (void)setFrontViewController:(UIViewController *)frontViewController
              focusAfterChange:(BOOL)focus
                    completion:(MCDefaultCompletionHandler)completion;

/**
 * Exchanges the current left view controller for a new one.
 *
 * @param leftViewController - The new left view controller.
 */
- (void)setLeftViewController:(UIViewController *)leftViewController;

/**
 * Exchanges the current right view controller for a new one.
 *
 * @param rightViewController - The new right view controller.
 */
- (void)setRightViewController:(UIViewController *)rightViewController;

/**
 * Adjusts the minimum reveal width of any given view controller's view.
 *
 * @param minWidth - The default (minimum) width of the view to be shown.
 * @param controller - The view controller whose view reveal sizing is being adjusted.
 */
- (void)setMinimumWidth:(CGFloat)minWidth
      forViewController:(UIViewController *)controller;

/**
 * @return UIViewController - Returns the currently focused controller, i.e. the one that's most prominent at any given point in time. 
 */
- (UIViewController *)focusedController;

/**
 * @return MCRevealControllerType - Returns the controller type, i.e. whether it has a left side, a right side, both or none.
 */
- (MCRevealControllerType)type;

/**
 * @return BOOL - Returns YES if the reveal controller has a right side, NO otherwise.
 */
- (BOOL)hasRightViewController;

/**
 * @return BOOL - Returns YES if the reveal controller has a left side, NO otherwise.
 */
- (BOOL)hasLeftViewController;

/**
 *  The following are useful query methods that can be used be the view transformers
 */
- (CGFloat)leftViewMaxWidth;
- (CGFloat)rightViewMaxWidth;
- (CGFloat)leftViewMinWidth;
- (CGFloat)rightViewMinWidth;

@end
