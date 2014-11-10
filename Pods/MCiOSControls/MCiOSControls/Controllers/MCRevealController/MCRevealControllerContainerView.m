//
//  MCRevealControllerContainerView.m
//
//  Created by Rayman Rosevear on 2013/08/16. Heavily based
//	off the implementation of PKRevealController by
//	Philip Kluz (https://github.com/pkluz/PKRevealController)
//  Copyright (c) 2013 Mushroom Cloud. All rights reserved.
//

#import "MCRevealControllerContainerView.h"

#import "UIView+MCFrameAdditions.h"

@interface MCRevealControllerContainerView()
{
	struct {
        unsigned int respondsToEdgesForExtendedLayout:1;
    } _flags;
}

#pragma mark - Properties
@property (nonatomic, assign, readwrite, getter = hasShadow) BOOL shadow;

- (void)updateViewFrame;

@end

@implementation MCRevealControllerContainerView

#pragma mark - Initialization

- (id)initForController:(UIViewController *)controller
{
    return [self initForController:controller shadow:NO];
}

- (id)initForController:(UIViewController *)controller shadow:(BOOL)hasShadow
{
    self = [super initWithFrame:controller.view.bounds];
    
    if (self != nil)
    {
        self.viewController = controller;
        if (hasShadow)
        {
            [self setupShadow];
        }
        self.shadow = hasShadow;
		self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

#pragma mark - Setup

- (void)setupShadow
{
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowRadius = 2.5f;
    self.layer.shadowPath = shadowPath.CGPath;
}

#pragma mark - Layouting

- (void)layoutSubviews
{
    [super layoutSubviews];
    // layout controller view
    [self updateViewFrame];
}

- (void)refreshShadowWithAnimationDuration:(NSTimeInterval)duration
{
    UIBezierPath *existingShadowPath = [UIBezierPath bezierPathWithCGPath:self.layer.shadowPath];
    
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    
    if (existingShadowPath != nil && duration > 0.0)
    {
        CABasicAnimation *transition = [CABasicAnimation animationWithKeyPath:@"shadowPath"];
        transition.fromValue = (__bridge id)(existingShadowPath.CGPath);
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.duration = duration;
		
        [self.layer addAnimation:transition forKey:@"transition"];
    }
}

#pragma mark - Accessors

- (void)setViewController:(UIViewController *)controller
{
    if (_viewController != controller)
    {
		_userInterActionEnabledForContainedView = _viewController.view.userInteractionEnabled;
		
        [_viewController.view removeFromSuperview];
        _viewController = controller;
		_flags.respondsToEdgesForExtendedLayout = [_viewController respondsToSelector:@selector(edgesForExtendedLayout)];
		_viewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		[self updateViewFrame];
        [self addSubview:_viewController.view];
    }
}

#pragma mark - Mutators

- (void)updateViewFrame
{
	self.viewController.view.frame = self.bounds;
	if (_flags.respondsToEdgesForExtendedLayout)
	{
		UIRectEdge edges = self.viewController.edgesForExtendedLayout;
		if (!(edges & UIRectEdgeTop))
		{
			self.viewController.view.$top = [self.topLayoutGuide length];
		}
		if (!(edges & UIRectEdgeBottom))
		{
			self.viewController.view.$bottom -= [self.bottomLayoutGuide length];
		}
	}
}

- (void)setTopLayoutGuide:(id<UILayoutSupport>)topLayoutGuide
{
	_topLayoutGuide = topLayoutGuide;
	if (self.viewController != nil)
	{
		[self updateViewFrame];
	}
}

- (void)setBottomLayoutGuide:(id<UILayoutSupport>)bottomLayoutGuide
{
	_bottomLayoutGuide = bottomLayoutGuide;
	if (self.viewController != nil)
	{
		[self updateViewFrame];
	}
}

- (void)setTopLayoutGuide:(id<UILayoutSupport>)topLayoutGuide bottomLayoutGuide:(id<UILayoutSupport>)bottomLayoutGuide
{
	_topLayoutGuide = topLayoutGuide;
	_bottomLayoutGuide = bottomLayoutGuide;
	if (self.viewController != nil)
	{
		[self updateViewFrame];
	}
}

#pragma mark - API

- (void)setUserInterActionEnabledForContainedView:(BOOL)userInterActionEnabledForContainedView
{
	_userInterActionEnabledForContainedView = userInterActionEnabledForContainedView;
	[self.viewController.view setUserInteractionEnabled:userInterActionEnabledForContainedView];
}

@end