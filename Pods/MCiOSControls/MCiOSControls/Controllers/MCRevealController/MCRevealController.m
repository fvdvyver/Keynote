//
//  MCRevealController.m
//
//  Created by Rayman Rosevear on 2013/08/16. Heavily based
//	off the implementation of PKRevealController by
//	Philip Kluz (https://github.com/pkluz/PKRevealController)
//  Copyright (c) 2013 Mushroom Cloud. All rights reserved.
//

#import "MCRevealController.h"

#import "MCRevealControllerContainerView.h"
#import "MCRevealViewTransformer.h"

#define DEFAULT_ANIMATION_DURATION_VALUE 0.3f
#define DEFAULT_ANIMATION_CURVE_VALUE UIViewAnimationOptionCurveEaseInOut
#define DEFAULT_LEFT_VIEW_WIDTH 280.0f
#define DEFAULT_RIGHT_VIEW_WIDTH DEFAULT_LEFT_VIEW_WIDTH
#define DEFAULT_ALLOWS_OVERDRAW_VALUE YES
#define DEFAULT_ANIMATION_TYPE_VALUE MCRevealControllerAnimationTypeStatic
#define DEFAULT_QUICK_SWIPE_TOGGLE_VELOCITY_VALUE 0.0f
#define DEFAULT_DISABLES_FRONT_VIEW_INTERACTION_VALUE YES
#define DEFAULT_RECOGNIZES_PAN_ON_VIEW_VALUE NO
#define DEFAULT_RECOGNIZES_PAN_ON_FRONT_VIEW_VALUE YES
#define DEFAULT_RECOGNIZES_RESET_TAP_ON_FRONT_VIEW_VALUE YES

/**
 *	Adds an action that is performed on the whole hierarchy
 */
@interface UIView (SuperviewHierarchyAction)

- (void)performSuperviewHierarchyAction:(void (^)(UIView *))action;

@end

@implementation UIView (SuperviewHierarchyAction)

- (void)performSuperviewHierarchyAction:(void (^)(UIView *))action
{
	action(self);
	[self.superview performSuperviewHierarchyAction:action];
}

@end

@interface MCRevealController () <UIGestureRecognizerDelegate>
{
	struct {
        unsigned int respondsToTopLayoutGuide:1;
    } _flags;
}

// *****************************************************************************************************
#pragma mark - Properties
// *****************************************************************************************************

@property (nonatomic, assign, readwrite) BOOL isSetup;

@property (nonatomic, assign, readwrite) MCRevealControllerState state;
@property (nonatomic, assign, readwrite) BOOL isPresentationModeActive;

@property (nonatomic, strong, readwrite) NSMutableSet *touchForwardingClasses;

@property (nonatomic, strong, readwrite) UIViewController *frontViewController;
@property (nonatomic, strong, readwrite) UIViewController *leftViewController;
@property (nonatomic, strong, readwrite) UIViewController *rightViewController;

@property (nonatomic, strong, readwrite) MCRevealControllerContainerView *frontViewContainer;
@property (nonatomic, strong, readwrite) MCRevealControllerContainerView *leftViewContainer;
@property (nonatomic, strong, readwrite) MCRevealControllerContainerView *rightViewContainer;

@property (nonatomic, assign, readwrite) CGFloat leftViewWidth;
@property (nonatomic, assign, readwrite) CGFloat rightViewWidth;

@property (nonatomic, strong, readwrite) NSMutableDictionary *controllerOptions;
@property (nonatomic, strong, readwrite) UIPanGestureRecognizer *revealPanGestureRecognizer;
@property (nonatomic, strong, readwrite) UITapGestureRecognizer *revealResetTapGestureRecognizer;

@property (nonatomic, assign, readwrite) CGPoint initialTouchLocation;
@property (nonatomic, assign, readwrite) CGPoint previousTouchLocation;

@property (nonatomic, assign, readwrite) CGFloat currentTranslation;

@property (nonatomic, assign, readwrite, getter = isAnimating) BOOL animating;

/**
 *	Returns YES if either the controller is equal to the appropriate controller,
 *	or if not, the parentViewController chain is visited until one of the 
 *	parent controllers is the appropriate controller
 */
- (BOOL)controllerIsFrontController:(UIViewController *)controller;
- (BOOL)controllerIsLeftController:(UIViewController *)controller;
- (BOOL)controllerIsRightController:(UIViewController *)controller;

@end

@implementation MCRevealController

NSString * const MCRevealControllerWillEnterPresentationModeNotification = @"MCRevealControllerWillEnterPresentationMode";
NSString * const MCRevealControllerWillResignPresentationModeNotification = @"MCRevealControllerWillResignPresentationMode";

NSString * const MCRevealControllerAnimationDurationKey				= @"MCRevealControllerAnimationDurationKey";
NSString * const MCRevealControllerAnimationCurveKey				= @"MCRevealControllerAnimationCurveKey";
NSString * const MCRevealControllerQuickSwipeToggleVelocityKey		= @"MCRevealControllerQuickSwipeToggleVelocityKey";
NSString * const MCRevealControllerDisablesFrontViewInteractionKey	= @"MCRevealControllerDisablesFrontViewInteractionKey";
NSString * const MCRevealControllerRecognizesPanningOnViewKey		= @"MCRevealControllerRecognizesPanningOnViewKey";
NSString * const MCRevealControllerRecognizesPanningOnFrontViewKey	= @"MCRevealControllerRecognizesPanningOnFrontViewKey";
NSString * const MCRevealControllerRecognizesResetTapOnFrontViewKey = @"MCRevealControllerRecognizesResetTapOnFrontViewKey";

// *****************************************************************************************************
#pragma mark - Initialization
// *****************************************************************************************************

+ (instancetype)revealControllerWithFrontViewController:(UIViewController *)frontViewController
                                     leftViewController:(UIViewController *)leftViewController
                                    rightViewController:(UIViewController *)rightViewController
                                                options:(NSDictionary *)options
{
    return [[[self class] alloc] initWithFrontViewController:frontViewController
                                          leftViewController:leftViewController
                                         rightViewController:rightViewController
                                                     options:options];
}

+ (instancetype)revealControllerWithFrontViewController:(UIViewController *)frontViewController
                                     leftViewController:(UIViewController *)leftViewController
                                                options:(NSDictionary *)options
{
    return [[[self class] alloc] initWithFrontViewController:frontViewController
                                          leftViewController:leftViewController
                                                     options:options];
}

+ (instancetype)revealControllerWithFrontViewController:(UIViewController *)frontViewController
                                    rightViewController:(UIViewController *)rightViewController
                                                options:(NSDictionary *)options
{
    return [[[self class] alloc] initWithFrontViewController:frontViewController
                                         rightViewController:rightViewController
                                                     options:options];
}

- (id)initWithFrontViewController:(UIViewController *)frontViewController
               leftViewController:(UIViewController *)leftViewController
                          options:(NSDictionary *)options
{
    return [self initWithFrontViewController:frontViewController
                          leftViewController:leftViewController
                         rightViewController:nil
                                     options:options];
}

- (id)initWithFrontViewController:(UIViewController *)frontViewController
              rightViewController:(UIViewController *)rightViewController
                          options:(NSDictionary *)options
{
    return [self initWithFrontViewController:frontViewController
                          leftViewController:nil
                         rightViewController:rightViewController
                                     options:options];
}

- (id)initWithFrontViewController:(UIViewController *)frontViewController
               leftViewController:(UIViewController *)leftViewController
              rightViewController:(UIViewController *)rightViewController
                          options:(NSDictionary *)options
{
    self = [super init];
    
    if (self != nil)
    {
        _frontViewController = frontViewController;
        _rightViewController = rightViewController;
        _leftViewController = leftViewController;
        
        [self commonInitializer];
        
        if (options)
        {
            _controllerOptions = [options mutableCopy];
			if ([_controllerOptions[MCRevealControllerRecognizesPanningOnViewKey] boolValue] == YES)
			{
				_controllerOptions[MCRevealControllerRecognizesPanningOnFrontViewKey] = @NO;
			}
        }
    }
    
    return self;
}

- (id)init
{
    self = [super init];
    
    if (self != nil)
    {
        [self commonInitializer];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self != nil)
    {
        [self commonInitializer];
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self != nil)
    {
        [self commonInitializer];
    }
    
    return self;
}

- (void)commonInitializer
{
    _controllerOptions = [NSMutableDictionary dictionaryWithCapacity:10];
    _frontViewController.revealController = self;
    _leftViewController.revealController = self;
    _rightViewController.revealController = self;
	
    _frontViewShadowColor = [UIColor blackColor];
    _frontViewShadowOpacity = 0.5f;
    _frontViewShadowOffset = CGSizeMake(0, 0);
    _frontViewShadowRadius = 2.5f;
    
	self.leftViewWidth = DEFAULT_LEFT_VIEW_WIDTH;
    self.rightViewWidth = DEFAULT_RIGHT_VIEW_WIDTH;
	
	self.touchForwardingClasses = [NSMutableSet setWithObjects:[UISlider class], [UISwitch class], nil];
}

// *****************************************************************************************************
#pragma mark - API
// *****************************************************************************************************

- (void)registerTouchForwardingClass:(Class)touchForwardingClass
{
	NSAssert([touchForwardingClass isSubclassOfClass:[UIView class]], @"Registered touch forwarding classes must be a subclass of UIView");
	[self.touchForwardingClasses addObject:touchForwardingClass];
}

- (void)unregisterTouchForwardingClass:(Class)touchForwardingClass
{
	[self.touchForwardingClasses removeObject:touchForwardingClass];
}

- (void)showViewController:(UIViewController *)controller
{
	if ([self isPresentationModeActive])
	{
		[[NSNotificationCenter defaultCenter] postNotificationName:MCRevealControllerWillResignPresentationModeNotification
															object:self];
	}
	
    [self showViewController:controller
                    animated:YES
                  completion:NULL];
}

- (void)showViewController:(UIViewController *)controller
                  animated:(BOOL)animated
                completion:(MCDefaultCompletionHandler)completion
{
    if ([self controllerIsLeftController:controller])
    {
        if ([self hasLeftViewController])
        {
            [self showLeftViewControllerAnimated:animated completion:completion];
        }
        
    }
    else if ([self controllerIsRightController:controller])
    {
        if ([self hasRightViewController])
        {
            [self showRightViewControllerAnimated:animated completion:completion];
        }
    }
    else if ([self controllerIsFrontController:controller])
    {
        [self showFrontViewControllerAnimated:animated completion:completion];
    }
}

- (void)enterPresentationModeAnimated:(BOOL)animated
                           completion:(MCDefaultCompletionHandler)completion
{
	if ([self isLeftViewVisible])
    {
		[[NSNotificationCenter defaultCenter] postNotificationName:MCRevealControllerWillEnterPresentationModeNotification
															object:self];
        [self enterPresentationModeForLeftViewControllerAnimated:animated
                                                      completion:completion];
    }
    else if ([self isRightViewVisible])
    {
		[[NSNotificationCenter defaultCenter] postNotificationName:MCRevealControllerWillEnterPresentationModeNotification
															object:self];
        [self enterPresentationModeForRightViewControllerAnimated:animated
                                                       completion:completion];
    }
    else if ([self hasLeftViewController])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:MCRevealControllerWillEnterPresentationModeNotification
                                                            object:self];
        [self addLeftViewControllerToHierarchy];
        [self enterPresentationModeForLeftViewControllerAnimated:animated
                                                      completion:completion];
    }
    else if ([self hasRightViewController])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:MCRevealControllerWillEnterPresentationModeNotification
                                                            object:self];
        [self addRightViewControllerToHierarchy];
        [self enterPresentationModeForRightViewControllerAnimated:animated
                                                       completion:completion];
    }
}

- (void)resignPresentationModeEntirely:(BOOL)entirely
                              animated:(BOOL)animated
                            completion:(MCDefaultCompletionHandler)completion
{
    if ([self isLeftViewVisible])
    {
		[[NSNotificationCenter defaultCenter] postNotificationName:MCRevealControllerWillResignPresentationModeNotification
															object:self];
        [self resignPresentationModeForLeftViewControllerEntirely:entirely
                                                         animated:animated
                                                       completion:^(BOOL finished)
		                                               {
                                                           if (entirely)
                                                           {
                                                               [self removeLeftViewControllerFromHierarchy];
                                                           }
														   safelyExecuteCompletionBlockOnMainThread(completion, finished);
													   }];
    }
    else if ([self isRightViewVisible])
    {
		[[NSNotificationCenter defaultCenter] postNotificationName:MCRevealControllerWillResignPresentationModeNotification
															object:self];
        [self resignPresentationModeForRightViewControllerEntirely:entirely
                                                          animated:animated
                                                        completion:^(BOOL finished)
		                                                {
                                                            if (entirely)
                                                            {
                                                                [self removeRightViewControllerFromHierarchy];
                                                            }
															safelyExecuteCompletionBlockOnMainThread(completion, finished);
														}];
    }
}

- (void)setFrontViewController:(UIViewController *)frontViewController
{
    if (_frontViewController != frontViewController)
    {
        if ([self isSetup])
        {
            [self removeFrontViewControllerFromHierarchy];
        }
        
        _frontViewController = frontViewController;
        _frontViewController.revealController = self;
        
        if ([self isSetup])
        {
            [self addFrontViewControllerToHierarchy];
        }
    }
}

- (void)setFrontViewController:(UIViewController *)frontViewController
              focusAfterChange:(BOOL)focus
                    completion:(MCDefaultCompletionHandler)completion
{
    [self setFrontViewController:frontViewController];
    
    if (focus && ([self isLeftViewVisible] || [self isRightViewVisible]))
    {
        [self showViewController:self.frontViewController
                        animated:YES
                      completion:completion];
    }
    else
    {
        safelyExecuteCompletionBlockOnMainThread(completion, YES);
    }
}

- (void)setLeftViewController:(UIViewController *)leftViewController
{
    if (_leftViewController != leftViewController)
    {
        if ([self isSetup] && [self isLeftViewVisible])
        {
            [self removeLeftViewControllerFromHierarchy];
        }
        
        _leftViewController = leftViewController;
        _leftViewController.revealController = self;
        
        if ([self isSetup] && [self isLeftViewVisible])
        {
            [self removeRightViewControllerFromHierarchy];
            [self addLeftViewControllerToHierarchy];
        }
    }
}

- (void)setRightViewController:(UIViewController *)rightViewController
{
    BOOL isRightViewVisible = (self.state == MCRevealControllerFocusesRightViewController);
    
    if (_rightViewController != rightViewController)
    {
        if ([self isSetup] && isRightViewVisible)
        {
            [self removeRightViewControllerFromHierarchy];
        }
        
        _rightViewController = rightViewController;
        _rightViewController.revealController = self;
        
        if ([self isSetup] && isRightViewVisible)
        {
            [self removeLeftViewControllerFromHierarchy];
            [self addRightViewControllerToHierarchy];
        }
    }
}

- (MCRevealControllerType)type
{
    if (self.frontViewController != nil && self.leftViewController != nil && self.rightViewController != nil)
    {
        return MCRevealControllerTypeBoth;
    }
    else if (self.frontViewController != nil && self.leftViewController != nil)
    {
        return MCRevealControllerTypeLeft;
    }
    else if (self.frontViewController != nil && self.rightViewController != nil)
    {
        return MCRevealControllerTypeRight;
    }
    
    return MCRevealControllerTypeNone;
}

- (BOOL)hasRightViewController
{
    return MCRevealControllerTypeRight == (self.type & MCRevealControllerTypeRight);
}

- (BOOL)hasLeftViewController
{
    return MCRevealControllerTypeLeft == (self.type & MCRevealControllerTypeLeft);
}

- (void)setMinimumWidth:(CGFloat)minWidth
      forViewController:(UIViewController *)controller
{
    if ([self controllerIsLeftController:controller])
    {
        self.leftViewWidth = minWidth;
    }
    else if ([self controllerIsRightController:controller])
    {
        self.rightViewWidth = minWidth;
    }
}

- (UIViewController *)focusedController
{
    UIViewController *returnViewController = nil;
    switch (self.state)
    {
        case MCRevealControllerFocusesFrontViewController:
            returnViewController = self.frontViewController;
            break;
            
        case MCRevealControllerFocusesLeftViewController:
            returnViewController =  self.leftViewController;
            break;
            
        case MCRevealControllerFocusesRightViewController:
            returnViewController = self.rightViewController;
            break;
            
        case MCRevealControllerFocusesLeftViewControllerInPresentationMode:
        case MCRevealControllerFocusesRightViewControllerInPresentationMode:
            break;
    }
    return returnViewController;
}

- (BOOL)isPresentationModeActive
{
    return (self.state == MCRevealControllerFocusesLeftViewControllerInPresentationMode
            || self.state == MCRevealControllerFocusesRightViewControllerInPresentationMode);
}

// *****************************************************************************************************
#pragma mark - View Lifecycle (System)
// *****************************************************************************************************

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setup];
    [self setupPanGestureRecognizer];
    [self setupTapGestureRecognizer];
    
    [self addFrontViewControllerToHierarchy];
    self.isSetup = YES;
}

- (void)viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];
	[self updateLayoutGuides];
}

// *****************************************************************************************************
#pragma mark - View Lifecycle (Controller)
// *****************************************************************************************************

- (void)addFrontViewControllerToHierarchy
{
    if (self.frontViewController != nil && ![self.childViewControllers containsObject:self.frontViewController])
    {
		[self.frontViewController beginAppearanceTransition:YES animated:NO];
        [self addChildViewController:self.frontViewController];
        self.frontViewContainer.viewController = self.frontViewController;
        
        if (self.frontViewContainer == nil)
        {
            self.frontViewContainer = [[MCRevealControllerContainerView alloc] initForController:self.frontViewController shadow:YES];
            self.frontViewContainer.layer.shadowColor = self.frontViewShadowColor.CGColor;
            self.frontViewContainer.layer.shadowOpacity = self.frontViewShadowOpacity;
            self.frontViewContainer.layer.shadowRadius = self.frontViewShadowRadius;
            self.frontViewContainer.layer.shadowOffset = self.frontViewShadowOffset;
		}
        
        self.frontViewContainer.frame = self.view.bounds;
        self.frontViewContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.frontViewTransformer transformView:self.frontViewContainer
                                  forTranslation:self.currentTranslation
                                      presenting:[self isPresentationModeActive]
                                    inController:self];
		
		[self.view addSubview:self.frontViewContainer];
		[self.frontViewController didMoveToParentViewController:self];
		[self.frontViewController endAppearanceTransition];
		
		if (_flags.respondsToTopLayoutGuide)
		{
			[self.frontViewContainer setTopLayoutGuide:self.topLayoutGuide bottomLayoutGuide:self.bottomLayoutGuide];
		}

        [self updatePanGestureRecognizer];
    }
}

- (void)removeFrontViewControllerFromHierarchy
{
    if ([self.childViewControllers containsObject:self.frontViewController])
    {
        [self removePanGestureRecognizerFromFrontView];
		
		[self.frontViewController beginAppearanceTransition:NO animated:NO];
		[self.frontViewController willMoveToParentViewController:nil];
        [self.frontViewContainer removeFromSuperview];
        [self.frontViewController removeFromParentViewController];
		[self.frontViewController endAppearanceTransition];
    }
}

- (void)addLeftViewControllerToHierarchy
{
    if (self.leftViewController != nil && ![self.childViewControllers containsObject:self.leftViewController])
    {
		[self.leftViewController beginAppearanceTransition:YES animated:NO];
        [self addChildViewController:self.leftViewController];
        self.leftViewContainer.viewController = self.leftViewController;
        
        if (self.leftViewContainer == nil)
        {
            self.leftViewContainer = [[MCRevealControllerContainerView alloc] initForController:self.leftViewController shadow:NO];
        }
        
        self.leftViewContainer.frame = self.view.bounds;
        self.leftViewContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self.view insertSubview:self.leftViewContainer belowSubview:self.frontViewContainer];
        [self.leftViewController didMoveToParentViewController:self];
		[self.leftViewController endAppearanceTransition];
		
		if (_flags.respondsToTopLayoutGuide)
		{
			[self.leftViewContainer setTopLayoutGuide:self.topLayoutGuide bottomLayoutGuide:self.bottomLayoutGuide];
		}
    }
}

- (void)removeLeftViewControllerFromHierarchy
{
    if ([self.childViewControllers containsObject:self.leftViewController])
    {	
		[self.leftViewController beginAppearanceTransition:NO animated:NO];
		[self.leftViewController willMoveToParentViewController:nil];
        [self.leftViewContainer removeFromSuperview];
        [self.leftViewController removeFromParentViewController];
		[self.leftViewController endAppearanceTransition];
    }
}

- (void)addRightViewControllerToHierarchy
{
    if (self.rightViewController != nil && ![self.childViewControllers containsObject:self.rightViewController])
    {
		[self.rightViewController beginAppearanceTransition:YES animated:NO];
        [self addChildViewController:self.rightViewController];
        self.rightViewContainer.viewController = self.rightViewController;
        
        if (self.rightViewContainer == nil)
        {
            self.rightViewContainer = [[MCRevealControllerContainerView alloc] initForController:self.rightViewController shadow:NO];
        }
        
        self.rightViewContainer.frame = self.view.bounds;
        self.rightViewContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self.view insertSubview:self.rightViewContainer belowSubview:self.frontViewContainer];
        [self.rightViewController didMoveToParentViewController:self];
		[self.rightViewController endAppearanceTransition];
		
		if (_flags.respondsToTopLayoutGuide)
		{
			[self.rightViewContainer setTopLayoutGuide:self.topLayoutGuide bottomLayoutGuide:self.bottomLayoutGuide];
		}
    }
}

- (void)removeRightViewControllerFromHierarchy
{
    if ([self.childViewControllers containsObject:self.rightViewController])
    {
		[self.rightViewController beginAppearanceTransition:NO animated:NO];
		[self.rightViewController willMoveToParentViewController:nil];
        [self.rightViewContainer removeFromSuperview];
        [self.rightViewController removeFromParentViewController];
		[self.rightViewController endAppearanceTransition];
    }
}

- (void)addPanGestureRecognizerToView
{
	[self.view addGestureRecognizer:self.revealPanGestureRecognizer];
}

- (void)removePanGestureRecognizerFromView
{
    if ([[self.view gestureRecognizers] containsObject:self.revealPanGestureRecognizer])
    {
        [self.view removeGestureRecognizer:self.revealPanGestureRecognizer];
    }
}

- (void)addPanGestureRecognizerToFrontView
{
    [self.frontViewContainer addGestureRecognizer:self.revealPanGestureRecognizer];
}

- (void)removePanGestureRecognizerFromFrontView
{
    if ([[self.frontViewContainer gestureRecognizers] containsObject:self.revealPanGestureRecognizer])
    {
        [self.frontViewContainer removeGestureRecognizer:self.revealPanGestureRecognizer];
    }
}

- (void)addTapGestureRecognizerToFrontView
{
    [self.frontViewContainer addGestureRecognizer:self.revealResetTapGestureRecognizer];
}

- (void)removeTapGestureRecognizerFromFrontView
{
    if ([[self.frontViewContainer gestureRecognizers] containsObject:self.revealResetTapGestureRecognizer])
    {
        [self.frontViewContainer removeGestureRecognizer:self.revealResetTapGestureRecognizer];
    }
}

- (void)updatePanGestureRecognizer
{
	[self removePanGestureRecognizerFromView];
	[self removePanGestureRecognizerFromFrontView];
	
    if (self.recognizesPanningOnFrontView)
    {
        [self addPanGestureRecognizerToFrontView];
    }
    else if(self.recognizesPanningOnView)
    {
        [self addPanGestureRecognizerToView];
    }
}

- (void)updateResetTapGestureRecognizer
{
    if (self.recognizesResetTapOnFrontView
        && (self.state != MCRevealControllerFocusesFrontViewController))
    {
        [self addTapGestureRecognizerToFrontView];
    }
    else
    {
        [self removeTapGestureRecognizerFromFrontView];
    }
}

- (void)updateLayoutGuides
{
	if (_flags.respondsToTopLayoutGuide)
	{
		id<UILayoutSupport> topLayoutGuide = self.topLayoutGuide;
		id<UILayoutSupport> bottomLayoutGuide = self.bottomLayoutGuide;
		
		[self.leftViewContainer setTopLayoutGuide:topLayoutGuide bottomLayoutGuide:bottomLayoutGuide];
		[self.frontViewContainer setTopLayoutGuide:topLayoutGuide bottomLayoutGuide:bottomLayoutGuide];
		[self.rightViewContainer setTopLayoutGuide:topLayoutGuide bottomLayoutGuide:bottomLayoutGuide];
	}
}

// *****************************************************************************************************
#pragma mark - Setup
// *****************************************************************************************************

- (void)setup
{
    self.state = MCRevealControllerFocusesFrontViewController;
    self.view.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
	_flags.respondsToTopLayoutGuide = [self respondsToSelector:@selector(topLayoutGuide)];
}

- (void)setupPanGestureRecognizer
{
    SEL panRecognitionCallback = @selector(didRecognizePanWithGestureRecognizer:);
    self.revealPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                              action:panRecognitionCallback];
    self.revealPanGestureRecognizer.delegate = self;
}

- (void)setupTapGestureRecognizer
{
    SEL tapRecognitionCallback = @selector(didRecognizeTapWithGestureRecognizer:);
    self.revealResetTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                   action:tapRecognitionCallback];
    self.revealResetTapGestureRecognizer.delegate = self;
}

// *****************************************************************************************************
#pragma mark - Options
// *****************************************************************************************************

- (NSDictionary *)options
{
    return (NSDictionary *)self.controllerOptions;
}

#pragma mark -

- (CGFloat)animationDuration
{
    NSNumber *number = (self.controllerOptions)[MCRevealControllerAnimationDurationKey];
    
    if (number == nil)
    {
        [self setAnimationDuration:DEFAULT_ANIMATION_DURATION_VALUE];
        return [self animationDuration];
    }
    else
    {
        return [number floatValue];
    }
}

- (void)setAnimationDuration:(CGFloat)animationDuration
{
    (self.controllerOptions)[MCRevealControllerAnimationDurationKey] = @(animationDuration);
}

#pragma mark -

- (UIViewAnimationOptions)animationCurve
{
    NSNumber *number = (self.controllerOptions)[MCRevealControllerAnimationCurveKey];
    
    if (number == nil)
    {
        [self setAnimationCurve:DEFAULT_ANIMATION_CURVE_VALUE];
        return [self animationCurve];
    }
    else
    {
        return (UIViewAnimationOptions)[number integerValue];
    }
}

- (void)setAnimationCurve:(UIViewAnimationOptions)animationCurve
{
    (self.controllerOptions)[MCRevealControllerAnimationCurveKey] = @(animationCurve);
}

#pragma mark -

- (void)setFrontViewShadowColor:(UIColor *)frontViewShadowColor
{
    _frontViewShadowColor = frontViewShadowColor;
    self.frontViewContainer.layer.shadowColor = self.frontViewShadowColor.CGColor;
}

- (void)setFrontViewShadowOpacity:(CGFloat)frontViewShadowOpacity
{
    _frontViewShadowOpacity = frontViewShadowOpacity;
    self.frontViewContainer.layer.shadowOpacity = self.frontViewShadowOpacity;
}

- (void)setFrontViewShadowRadius:(CGFloat)frontViewShadowRadius
{
    _frontViewShadowRadius = frontViewShadowRadius;
    self.frontViewContainer.layer.shadowRadius = self.frontViewShadowRadius;
}

- (void)setFrontViewShadowOffset:(CGSize)frontViewShadowOffset
{
    _frontViewShadowOffset = frontViewShadowOffset;
    self.frontViewContainer.layer.shadowOffset = self.frontViewShadowOffset;
}

#pragma mark -

- (MCRevealViewTransformer *)frontViewTransformer
{
    if (_frontViewTransformer == nil)
    {
        _frontViewTransformer = [[MCFrontOverdrawViewTransformer alloc] initWithPosition:0];
    }
    return _frontViewTransformer;
}

- (MCRevealViewTransformer *)leftViewTransformer
{
    if (_leftViewTransformer == nil)
    {
        _leftViewTransformer = [[MCRevealViewTransformer alloc] initWithPosition:MCRevealControllerViewPositionLeft];
    }
    return _leftViewTransformer;
}

- (MCRevealViewTransformer *)rightViewTransformer
{
    if (_rightViewContainer == nil)
    {
        _rightViewTransformer = [[MCRevealViewTransformer alloc] initWithPosition:MCRevealControllerViewPositionRight];
    }
    return _rightViewTransformer;
}

#pragma mark -

- (void)setQuickSwipeVelocity:(CGFloat)quickSwipeVelocity
{
    (self.controllerOptions)[MCRevealControllerQuickSwipeToggleVelocityKey] = @(quickSwipeVelocity);
}

- (CGFloat)quickSwipeVelocity
{
    NSNumber *number = (self.controllerOptions)[MCRevealControllerQuickSwipeToggleVelocityKey];
    
    if (number == nil)
    {
        [self setQuickSwipeVelocity:DEFAULT_QUICK_SWIPE_TOGGLE_VELOCITY_VALUE];
        return [self quickSwipeVelocity];
    }
    else
    {
        return [number floatValue];
    }
}

#pragma mark -

- (BOOL)disablesFrontViewInteraction
{
    NSNumber *number = (self.controllerOptions)[MCRevealControllerDisablesFrontViewInteractionKey];
    
    if (number == nil)
    {
        [self setDisablesFrontViewInteraction:DEFAULT_DISABLES_FRONT_VIEW_INTERACTION_VALUE];
        return [self disablesFrontViewInteraction];
    }
    else
    {
        return [number boolValue];
    }
}

- (void)setDisablesFrontViewInteraction:(BOOL)disablesFrontViewInteraction
{
    (self.controllerOptions)[MCRevealControllerDisablesFrontViewInteractionKey] = @(disablesFrontViewInteraction);
}

#pragma mark -

- (void)setRecognizesPanningOnView:(BOOL)recognizesPanningOnView
{
	self.controllerOptions[MCRevealControllerRecognizesPanningOnViewKey] = @(recognizesPanningOnView);
    if ([self isSetup])
    {
        if (recognizesPanningOnView && [self recognizesPanningOnFrontView])
        {
            [self setRecognizesPanningOnFrontView:NO];
        }
        [self updatePanGestureRecognizer];
    }
}

- (BOOL)recognizesPanningOnView
{
	NSNumber *number = self.controllerOptions[MCRevealControllerRecognizesPanningOnViewKey];
	
	if (number == nil)
	{
		[self setRecognizesPanningOnView:DEFAULT_RECOGNIZES_PAN_ON_VIEW_VALUE];
		return [self recognizesPanningOnView];
	}
	
	return [number boolValue];
}

#pragma mark -

- (void)setRecognizesPanningOnFrontView:(BOOL)recognizesPanningOnFrontView
{
    self.controllerOptions[MCRevealControllerRecognizesPanningOnFrontViewKey] = @(recognizesPanningOnFrontView);
    if ([self isSetup])
    {
        if (recognizesPanningOnFrontView && [self recognizesPanningOnView])
        {
            [self setRecognizesPanningOnView:NO];
        }
        [self updatePanGestureRecognizer];
    }
}

- (BOOL)recognizesPanningOnFrontView
{
    NSNumber *number = (self.controllerOptions)[MCRevealControllerRecognizesPanningOnFrontViewKey];
    
    if (number == nil)
    {
		BOOL recognizesPanningOnFrontView = !self.recognizesPanningOnView;
        [self setRecognizesPanningOnFrontView:recognizesPanningOnFrontView];
        return [self recognizesPanningOnFrontView];
    }

	return [number boolValue];
}

#pragma mark -

- (void)setRecognizesResetTapOnFrontView:(BOOL)recognizesResetTapOnFrontView
{
    (self.controllerOptions)[MCRevealControllerRecognizesResetTapOnFrontViewKey] = @(recognizesResetTapOnFrontView);
    [self updateResetTapGestureRecognizer];
}

- (BOOL)recognizesResetTapOnFrontView
{
    NSNumber *number = (self.controllerOptions)[MCRevealControllerRecognizesResetTapOnFrontViewKey];
    
    if (number == nil)
    {
        [self setRecognizesResetTapOnFrontView:DEFAULT_RECOGNIZES_RESET_TAP_ON_FRONT_VIEW_VALUE];
        return [self recognizesResetTapOnFrontView];
    }
    else
    {
        return [number boolValue];
    }
}

// *****************************************************************************************************
#pragma mark - Accessors/Mutators
// *****************************************************************************************************

- (void)setState:(MCRevealControllerState)state
{
	BOOL presentationModeActiveBefore = [self isPresentationModeActive];
	_state = state;
	BOOL presentationModeActive = [self isPresentationModeActive];
	
	if (presentationModeActiveBefore && presentationModeActive == NO)
	{
		self.revealPanGestureRecognizer.enabled = YES;
	}
	else if (presentationModeActiveBefore == NO && presentationModeActive)
	{
		self.revealPanGestureRecognizer.enabled = NO;
	}
}

// *****************************************************************************************************
#pragma mark - Gesture Recognition
// *****************************************************************************************************

- (void)didRecognizeTapWithGestureRecognizer:(UITapGestureRecognizer *)recognizer
{
    [self showViewController:self.frontViewController];
}

- (void)didRecognizePanWithGestureRecognizer:(UIPanGestureRecognizer *)recognizer
{
	if ([self isAnimating])
	{
		return;
	}
	
    switch (recognizer.state)
    {
        case UIGestureRecognizerStateBegan:
            [self handleGestureBeganWithRecognizer:recognizer];
            break;
            
        case UIGestureRecognizerStateChanged:
            [self handleGestureChangedWithRecognizer:recognizer];
            break;
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            [self handleGestureEndedWithRecognizer:recognizer];
            break;
                        
        default:
        {
            self.revealPanGestureRecognizer.enabled = YES;
        }
            break;
    }
}

// *****************************************************************************************************
#pragma mark - Gesture Handling
// *****************************************************************************************************

- (void)handleGestureBeganWithRecognizer:(UIPanGestureRecognizer *)recognizer
{
	[self.frontViewContainer refreshShadowWithAnimationDuration:0.0f];
	self.initialTouchLocation = [recognizer locationInView:self.view];
    self.previousTouchLocation = self.initialTouchLocation;
	
	self.frontViewContainer.userInterActionEnabledForContainedView = NO;
}

- (void)handleGestureChangedWithRecognizer:(UIPanGestureRecognizer *)recognizer
{
	CGPoint currentTouchLocation = [recognizer locationInView:self.view];
    CGFloat delta = currentTouchLocation.x - self.previousTouchLocation.x;
    self.previousTouchLocation = currentTouchLocation;
    
    [self translateViewsBy:delta];
    [self adjustLeftAndRightViewVisibilities];
}

- (void)handleGestureEndedWithRecognizer:(UIPanGestureRecognizer *)recognizer
{
    CGFloat velocity = [recognizer velocityInView:self.view].x;
	
    if ([self shouldMoveFrontViewRightwardsForVelocity:velocity])
    {
		UIViewAnimationOptions animationCurve = self.animationCurve;
		CGFloat animationDuration = self.animationDuration;
		self.animationCurve = UIViewAnimationCurveEaseOut;
		self.animationDuration = [self animationDurationForVelocity:velocity];
		
        [self moveFrontViewRightwardsIfPossible];
		
		self.animationCurve = animationCurve;
		self.animationDuration = animationDuration;
    }
    else if ([self shouldMoveFrontViewLeftwardsForVelocity:velocity])
    {
		UIViewAnimationOptions animationCurve = self.animationCurve;
		CGFloat animationDuration = self.animationDuration;
		self.animationCurve = UIViewAnimationCurveEaseOut;
		self.animationDuration = [self animationDurationForVelocity:velocity];
		
        [self moveFrontViewLeftwardsIfPossible];
		
		self.animationCurve = animationCurve;
		self.animationDuration = animationDuration;
    }
    else
    {
        [self snapFrontViewToClosestEdge];
    }
}

// *****************************************************************************************************
#pragma mark - Gesture Delegation
// *****************************************************************************************************

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
	BOOL shouldReceiveTouch = YES;
	if (gestureRecognizer == self.revealPanGestureRecognizer)
    {
		__block BOOL isTouchForwardingClass = NO;
		[touch.view performSuperviewHierarchyAction:^(UIView *view)
		{
			if (isTouchForwardingClass)
			{
				// we have already found this to be a touch forwarding class.
				// There is no need to test further
				return;
			}
			
			for (Class touchForwardingClass in self.touchForwardingClasses)
			{
				if ([view isKindOfClass:touchForwardingClass])
				{
					isTouchForwardingClass = YES;
					break;
				}
			}
		}];
		shouldReceiveTouch = !isTouchForwardingClass;
    }
	
	return shouldReceiveTouch;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
	if (gestureRecognizer == self.revealPanGestureRecognizer)
    {
        CGPoint translation = [self.revealPanGestureRecognizer translationInView:self.frontViewContainer];
        return [self isAnimating] == NO && (fabs(translation.x) >= fabs(translation.y));
    }
    else if (gestureRecognizer == self.revealResetTapGestureRecognizer)
    {
        return ([self isLeftViewVisible] || [self isRightViewVisible]);
    }
    
    return YES;
}

// *****************************************************************************************************
#pragma mark - Translation
// *****************************************************************************************************

- (void)translateViewsBy:(CGFloat)delta
{
    CGFloat translation = self.currentTranslation + delta;//(self.previousTouchLocation.x - self.initialTouchLocation.x);
    
    [self.frontViewTransformer transformView:self.frontViewContainer forTranslation:translation presenting:NO inController:self];
    [self.leftViewTransformer transformView:self.leftViewContainer forTranslation:translation presenting:NO inController:self];
    [self.rightViewTransformer transformView:self.rightViewContainer forTranslation:translation presenting:NO inController:self];
    
    self.currentTranslation = translation;
}

- (void)moveFrontViewRightwardsIfPossible
{
    CGFloat originX = [self currentFrontViewTranslation];
    
    if (isNegative(originX) || ![self hasLeftViewController])
    {
        [self showViewController:self.frontViewController];
    }
    else
    {
        [self showViewController:self.leftViewController];
    }
}

- (void)moveFrontViewLeftwardsIfPossible
{
    CGFloat originX = [self currentFrontViewTranslation];
    
    if ((isNegative(originX) || isZero(originX)) && [self hasRightViewController])
    {
        [self showViewController:self.rightViewController];
    }
    else
    {
        [self showViewController:self.frontViewController];
    }
}

// *****************************************************************************************************
#pragma mark - Helper (Internal)
// *****************************************************************************************************

- (void)showLeftViewControllerAnimated:(BOOL)animated
                            completion:(MCDefaultCompletionHandler)completion
{
    __weak MCRevealController *weakSelf = self;
    
    void (^showLeftViewBlock)(BOOL finished) = ^(BOOL finished)
    {
        [weakSelf removeRightViewControllerFromHierarchy];
        [weakSelf addLeftViewControllerToHierarchy];
        
        [weakSelf setFrontViewTranslation:[weakSelf frontViewContainerOffsetForVisibleLeftView]
                               presenting:NO
                           animated:animated
                         completion:^(BOOL isFinished)
         {
             if (weakSelf.disablesFrontViewInteraction)
             {
                 weakSelf.frontViewContainer.userInterActionEnabledForContainedView = NO;
             }
			 else if (!weakSelf.frontViewContainer.userInterActionEnabledForContainedView)
			 {
				 weakSelf.frontViewContainer.userInterActionEnabledForContainedView = YES;
			 }
			 
             weakSelf.state = MCRevealControllerFocusesLeftViewController;
             [weakSelf removeRightViewControllerFromHierarchy];
             [weakSelf updateResetTapGestureRecognizer];
             safelyExecuteCompletionBlockOnMainThread(completion, isFinished);
         }];
    };
    
    if ([self isRightViewVisible])
    {
        [self showFrontViewControllerAnimated:animated
                                   completion:^(BOOL finished)
		 {
			 showLeftViewBlock(finished);
		 }];
    }
    else
    {
        showLeftViewBlock(YES);
    }
}


- (void)showRightViewControllerAnimated:(BOOL)animated
                             completion:(MCDefaultCompletionHandler)completion
{
    __weak MCRevealController *weakSelf = self;
    
    void (^showRightViewBlock)(BOOL finished) = ^(BOOL finished)
    {
        [weakSelf removeLeftViewControllerFromHierarchy];
        [weakSelf addRightViewControllerToHierarchy];
        
        [weakSelf setFrontViewTranslation:[weakSelf frontViewContainerOffsetForVisibleRightView]
                               presenting:NO
								 animated:animated
							   completion:^(BOOL isFinished)
		 {
			 if (weakSelf.disablesFrontViewInteraction)
			 {
				 weakSelf.frontViewContainer.userInterActionEnabledForContainedView = NO;
			 }
			 else if (!weakSelf.frontViewContainer.userInterActionEnabledForContainedView)
			 {
				 weakSelf.frontViewContainer.userInterActionEnabledForContainedView = YES;
			 }
			 
			 weakSelf.state = MCRevealControllerFocusesRightViewController;
			 [weakSelf updateResetTapGestureRecognizer];
			 safelyExecuteCompletionBlockOnMainThread(completion, isFinished);
		 }];
    };
    
    if ([self isLeftViewVisible])
    {
        [self showFrontViewControllerAnimated:animated
                                   completion:^(BOOL finished)
		 {
			 showRightViewBlock(finished);
		 }];
    }
    else
    {
        showRightViewBlock(YES);
    }
}


- (void)showFrontViewControllerAnimated:(BOOL)animated
                             completion:(MCDefaultCompletionHandler)completion
{
    __weak MCRevealController *weakSelf = self;
    
    [self setFrontViewTranslation:[self frontViewContainerOffsetForCenter]
                       presenting:NO
						 animated:animated
					   completion:^(BOOL finished)
     {
         if (!weakSelf.frontViewContainer.userInterActionEnabledForContainedView)
         {
             weakSelf.frontViewContainer.userInterActionEnabledForContainedView = YES;
         }
         weakSelf.state = MCRevealControllerFocusesFrontViewController;
         [weakSelf removeRightViewControllerFromHierarchy];
         [weakSelf removeLeftViewControllerFromHierarchy];
         [weakSelf updateResetTapGestureRecognizer];
         safelyExecuteCompletionBlockOnMainThread(completion, finished);
     }];
}

- (void)enterPresentationModeForLeftViewControllerAnimated:(BOOL)animated
                                                completion:(MCDefaultCompletionHandler)completion
{
    __weak MCRevealController *weakSelf = self;
    
    [self setFrontViewTranslation:[self frontViewContainerOffsetForLeftViewPresentationMode]
                       presenting:YES
						 animated:animated
					   completion:^(BOOL finished)
	 {
		 weakSelf.state = MCRevealControllerFocusesLeftViewControllerInPresentationMode;
		 safelyExecuteCompletionBlockOnMainThread(completion, finished);
	 }];
}

- (void)enterPresentationModeForRightViewControllerAnimated:(BOOL)animated
                                                 completion:(MCDefaultCompletionHandler)completion
{
    __weak MCRevealController *weakSelf = self;
    
    [self setFrontViewTranslation:[self frontViewContainerOffsetForRightViewPresentationMode]
                       presenting:YES
						 animated:animated
					   completion:^(BOOL finished)
	 {
		 weakSelf.state = MCRevealControllerFocusesRightViewControllerInPresentationMode;
		 safelyExecuteCompletionBlockOnMainThread(completion, finished);
	 }];
}

- (void)resignPresentationModeForLeftViewControllerEntirely:(BOOL)entirely
                                                   animated:(BOOL)animated
                                                 completion:(MCDefaultCompletionHandler)completion
{
    __weak MCRevealController *weakSelf = self;
    
    CGFloat offset;
    MCRevealControllerState state;
    
    if (entirely)
    {
        offset = [self frontViewContainerOffsetForCenter];
        state = MCRevealControllerFocusesFrontViewController;
    }
    else
    {
        offset = [self frontViewContainerOffsetForVisibleLeftView];
        state = MCRevealControllerFocusesLeftViewController;
    }
    
    [self setFrontViewTranslation:offset
                       presenting:NO
						 animated:animated
					   completion:^(BOOL finished)
	 {
		 if (entirely && !weakSelf.frontViewContainer.userInterActionEnabledForContainedView)
		 {
			 weakSelf.frontViewContainer.userInterActionEnabledForContainedView = YES;
		 }
		 weakSelf.state = state;
		 safelyExecuteCompletionBlockOnMainThread(completion, finished);
	 }];
}

- (void)resignPresentationModeForRightViewControllerEntirely:(BOOL)entirely
                                                    animated:(BOOL)animated
                                                  completion:(MCDefaultCompletionHandler)completion
{
    __weak MCRevealController *weakSelf = self;
    
    CGFloat offset;
    MCRevealControllerState state;
    
    if (entirely)
    {
        offset = [self frontViewContainerOffsetForCenter];
        state = MCRevealControllerFocusesFrontViewController;
    }
    else
    {
        offset = [self frontViewContainerOffsetForVisibleRightView];
        state = MCRevealControllerFocusesRightViewController;
    }
    
    [self setFrontViewTranslation:offset presenting:NO animated:animated completion:^(BOOL finished)
    {
        if (entirely && !weakSelf.frontViewContainer.userInterActionEnabledForContainedView)
        {
            weakSelf.frontViewContainer.userInterActionEnabledForContainedView = YES;
        }
        weakSelf.state = state;
        safelyExecuteCompletionBlockOnMainThread(completion, finished);
    }];
}

#pragma mark -

- (void)setFrontViewTranslation:(CGFloat)translation
                     presenting:(BOOL)isPresenting
					   animated:(BOOL)animated
					 completion:(MCDefaultCompletionHandler)completion
{
    CGFloat duration = animated ? [self animationDuration] : 0.0f;
    UIViewAnimationOptions options = (UIViewAnimationOptionBeginFromCurrentState | [self animationCurve]);
    
	CGFloat frontContainerFromFrameMinX = [self currentFrontViewTranslation];
	CGFloat frontContainerToFrameMinX = translation;
	BOOL isPositiveTranslation = (frontContainerFromFrameMinX < frontContainerToFrameMinX);
	BOOL isNegativeTranslation = (frontContainerFromFrameMinX > frontContainerToFrameMinX);
	
	BOOL animateLeft = isPositive(frontContainerFromFrameMinX) || (isZero(frontContainerFromFrameMinX) && isPositiveTranslation);
	BOOL animateRight = isNegative(frontContainerFromFrameMinX) || (isZero(frontContainerFromFrameMinX) && isNegativeTranslation);
	
	if (animateLeft)
	{
        [self.leftViewTransformer transformView:self.leftViewContainer
                                 forTranslation:frontContainerFromFrameMinX
                                     presenting:isPresenting
                                   inController:self];
	}
	else if (animateRight)
	{
        [self.rightViewTransformer transformView:self.rightViewContainer
                                  forTranslation:frontContainerFromFrameMinX
                                      presenting:isPresenting
                                    inController:self];
	}
	
	MCDefaultCompletionHandler completionBlock = ^(BOOL finished)
	{
		self.animating = NO;
		completion(finished);
	};
	
	self.animating = YES;
	[UIView animateWithDuration:duration delay:0.0f options:options animations:^
	{
        [self.frontViewTransformer transformView:self.frontViewContainer forTranslation:translation presenting:isPresenting inController:self];
        self.currentTranslation = translation;
		
		if (animateLeft)
		{
            [self.leftViewTransformer transformView:self.leftViewContainer
                                     forTranslation:frontContainerToFrameMinX
                                         presenting:isPresenting
                                       inController:self];
		}
		else if (animateRight)
		{
            [self.rightViewTransformer transformView:self.rightViewContainer
                                      forTranslation:frontContainerToFrameMinX
                                          presenting:isPresenting
                                        inController:self];
		}
	}
	completion:^(BOOL finished)
	{
		safelyExecuteCompletionBlockOnMainThread(completionBlock, finished);
	}];
    
    [self.frontViewContainer refreshShadowWithAnimationDuration:duration];
}

// *****************************************************************************************************
#pragma mark - Helpers (Gestures)
// *****************************************************************************************************

- (BOOL)shouldMoveFrontViewRightwardsForVelocity:(CGFloat)velocity
{
    return (isPositive(velocity) && velocity > self.quickSwipeVelocity);
}

- (CGFloat)animationDurationForVelocity:(CGFloat)velocity
{
	CGFloat duration = self.animationDuration;
	const CGFloat maxDuration = 0.4;
	
	if (isPositive(velocity))
	{
		CGFloat originX = [self currentFrontViewTranslation];
		
		if (isNegative(originX))
		{
			// Front view controller will be shown
			CGFloat distance = fabs(originX);
			duration = distance / fabs(velocity);
		}
		else
		{
			// Left view controller will be shown
			CGFloat frontTranslation = [self frontViewContainerOffsetForVisibleLeftView];
			CGFloat distance = frontTranslation - originX;
			BOOL rightTranslation = distance >= 0.0f;
			duration = rightTranslation ? distance / fabs(velocity) : maxDuration;
		}
	}
	else if (isNegative(velocity))
	{
		CGFloat originX = [self currentFrontViewTranslation];
		
		if (isNegative(originX) || isZero(originX))
		{
			// Right view controller will be shown
			CGFloat frontTranslation = [self frontViewContainerOffsetForVisibleRightView];
			CGFloat distance = frontTranslation - originX;
			BOOL leftTranslation = distance <= 0.0f;
			duration = leftTranslation ? -distance / fabs(velocity) : maxDuration;
		}
		else
		{
			// Front view controller will be shown
			// Front view controller will be shown
			CGFloat distance = fabs(originX);
			duration = distance / fabs(velocity);
		}
	}
	
	return MIN(duration, maxDuration);
}

- (BOOL)shouldMoveFrontViewLeftwardsForVelocity:(CGFloat)velocity
{
    return (isNegative(velocity) && fabsf(velocity) > self.quickSwipeVelocity);
}

- (void)snapFrontViewToClosestEdge
{
    UIViewController *controllerToShow = nil;
    
    if ([self isLeftViewVisible])
    {
        BOOL showLeftView = [self currentFrontViewTranslation] > CGRectGetWidth(self.view.bounds) / 2.0f;
        controllerToShow = showLeftView ? self.leftViewController : self.frontViewController;
    }
    else if ([self isRightViewVisible])
    {
        BOOL showRightView = -[self currentFrontViewTranslation] > CGRectGetWidth(self.view.bounds) / 2.0f;
        controllerToShow = showRightView ? self.rightViewController : self.frontViewController;
    }
    else
    {
        controllerToShow = self.frontViewController;
    }
    
    [self showViewController:controllerToShow];
}

// *****************************************************************************************************
#pragma mark - Helpers (States)
// *****************************************************************************************************

- (BOOL)isLeftViewVisible
{
    return isPositive([self currentFrontViewTranslation]);
}

- (BOOL)isRightViewVisible
{
    return isNegative([self currentFrontViewTranslation]);
}

- (void)adjustLeftAndRightViewVisibilities
{
    CGFloat originX = [self currentFrontViewTranslation];
    
    if (isPositive(originX))
    {
        [self removeRightViewControllerFromHierarchy];
        [self addLeftViewControllerToHierarchy];
    }
    else
    {
        [self removeLeftViewControllerFromHierarchy];
        [self addRightViewControllerToHierarchy];
    }
}

- (BOOL)controllerIsFrontController:(UIViewController *)controller
{
	UIViewController *parent = controller;
	BOOL isFront = NO;
	do
	{
		if (parent == self.frontViewController)
		{
			isFront = YES;
		}
		else
		{
			parent = parent.parentViewController;
		}
	}
	while (isFront == NO && parent != nil);
	
	return isFront;
}

- (BOOL)controllerIsLeftController:(UIViewController *)controller
{
	UIViewController *parent = controller;
	BOOL isLeft = NO;
	do
	{
		if (parent == self.leftViewController)
		{
			isLeft = YES;
		}
		else
		{
			parent = parent.parentViewController;
		}
	}
	while (isLeft == NO && parent != nil);
	
	return isLeft;
}

- (BOOL)controllerIsRightController:(UIViewController *)controller
{
	UIViewController *parent = controller;
	BOOL isRight = NO;
	do
	{
		if (parent == self.rightViewController)
		{
			isRight = YES;
		}
		else
		{
			parent = parent.parentViewController;
		}
	}
	while (isRight == NO && parent != nil);
	
	return isRight;
}

// *****************************************************************************************************
#pragma mark - Helper (Sizing)
// *****************************************************************************************************

- (CGFloat)leftViewMaxWidth
{
	return CGRectGetWidth(self.view.bounds);
}

- (CGFloat)rightViewMaxWidth
{
	return CGRectGetWidth(self.view.bounds);
}

- (CGFloat)leftViewMinWidth
{
    return self.leftViewWidth;
}

- (CGFloat)rightViewMinWidth
{
    return self.rightViewWidth;
}

// *****************************************************************************************************
#pragma mark - Helper (Container Offsets)
// *****************************************************************************************************

- (CGFloat)currentFrontViewTranslation
{
    return self.currentTranslation;
}

- (CGFloat)frontViewContainerOffsetForCurrentState
{
	CGFloat offset = 0.0f;
    switch (self.state)
    {
        case MCRevealControllerFocusesFrontViewController:
            offset = [self frontViewContainerOffsetForCenter];
            break;
            
        case MCRevealControllerFocusesLeftViewController:
            offset = [self frontViewContainerOffsetForVisibleLeftView];
            break;
            
        case MCRevealControllerFocusesRightViewController:
            offset = [self frontViewContainerOffsetForVisibleRightView];
            break;
            
        case MCRevealControllerFocusesLeftViewControllerInPresentationMode:
			offset = self.view.bounds.size.width;
			break;
			
        case MCRevealControllerFocusesRightViewControllerInPresentationMode:
			offset = -self.view.bounds.size.width;
            break;
    }
    
    return offset;
}

- (CGFloat)frontViewContainerOffsetForVisibleLeftView
{
    return [self leftViewMinWidth];
}

- (CGFloat)frontViewContainerOffsetForVisibleRightView
{
    return -[self rightViewMinWidth];
}

- (CGFloat)frontViewContainerOffsetForCenter
{
    return 0.0f;
}

- (CGFloat)frontViewContainerOffsetForLeftViewPresentationMode
{
    return [self leftViewMaxWidth];
}

- (CGFloat)frontViewContainerOffsetForRightViewPresentationMode
{
    return -[self rightViewMaxWidth];
}

// *****************************************************************************************************
#pragma mark - Autorotation
// *****************************************************************************************************

/*
 * Please Note: The MCRevealController will only rotate if, and only if,
 * all the controllers support the requested orientation.
 */
- (BOOL)shouldAutorotate
{
	// Do not rotate if we are in presentation mode
	if ([self isPresentationModeActive])
	{
		return NO;
	}
	
    if ([self hasLeftViewController] && [self hasRightViewController])
    {
        return [self.frontViewController shouldAutorotate]
            && [self.leftViewController shouldAutorotate]
            && [self.rightViewController shouldAutorotate];
    }
    else if ([self hasLeftViewController])
    {
        return [self.frontViewController shouldAutorotate]
            && [self.leftViewController shouldAutorotate];
    }
    else if ([self hasRightViewController])
    {
        return [self.frontViewController shouldAutorotate]
            && [self.rightViewController shouldAutorotate];
    }
    else
    {
        return [self.frontViewController shouldAutorotate];
    }
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([self hasLeftViewController] && [self hasRightViewController])
    {
        return self.frontViewController.supportedInterfaceOrientations
             & self.leftViewController.supportedInterfaceOrientations
             & self.rightViewController.supportedInterfaceOrientations;
    }
    else if ([self hasLeftViewController])
    {
        return self.frontViewController.supportedInterfaceOrientations
             & self.leftViewController.supportedInterfaceOrientations;
    }
    else if ([self hasRightViewController])
    {
        return self.frontViewController.supportedInterfaceOrientations
             & self.rightViewController.supportedInterfaceOrientations;
    }
    else
    {
        return self.frontViewController.supportedInterfaceOrientations;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return [self.frontViewController shouldAutorotateToInterfaceOrientation:toInterfaceOrientation]
        && [self.leftViewController shouldAutorotateToInterfaceOrientation:toInterfaceOrientation]
        && [self.rightViewController shouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration
{
    [self.frontViewContainer refreshShadowWithAnimationDuration:duration];
}

// *****************************************************************************************************
#pragma mark - Memory Management
// *****************************************************************************************************

- (void)dealloc
{
    [self.frontViewController removeFromParentViewController];
    [self.frontViewController.view removeFromSuperview];
    self.frontViewContainer = nil;
    
    [self.leftViewController removeFromParentViewController];
    [self.leftViewController.view removeFromSuperview];
    self.leftViewContainer = nil;
	
    [self.rightViewController removeFromParentViewController];
    [self.rightViewController.view removeFromSuperview];
    self.rightViewContainer = nil;
}

// *****************************************************************************************************
#pragma mark - Helpers (Generic)
// *****************************************************************************************************

NS_INLINE BOOL isPositive(CGFloat value)
{
    return (value > 0.0f);
}

NS_INLINE BOOL isNegative(CGFloat value)
{
    return (value < 0.0f);
}

NS_INLINE BOOL isZero(CGFloat value)
{
    return (value == 0.0f);
}

NS_INLINE void safelyExecuteCompletionBlockOnMainThread(MCDefaultCompletionHandler block, BOOL finished)
{
    void(^executeBlock)() = ^()
    {
        if (block != NULL)
        {
            block(finished);
        }
    };
    
    if ([NSThread isMainThread])
    {
        executeBlock();
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), executeBlock);
    }
}

@end
