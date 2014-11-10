//
//  MCSideViewController.m
//  ComSecure
//
//  Created by Rayman Rosevear on 2013/09/18.
//  Copyright (c) 2013 Mushroom Cloud. All rights reserved.
//

#import "MCSideViewController.h"
#import "MCRevealController.h"
#import "UIView+MCFrameAdditions.h"

@interface MCSideViewController ()

@property (nonatomic, assign) BOOL presentationModeActive;

@property (nonatomic, strong, readwrite) UIViewController *viewController;

- (void)presentationModeEntered:(NSNotification *)notification;
- (void)presentationModeResigned:(NSNotification *)notification;

- (void)adjustOverdrawInsets;

@end

@implementation MCSideViewController

- (id)initWithViewController:(UIViewController *)viewController
{
	if (self = [super init])
	{
		_viewController = viewController;
		
		const CGFloat screenWidth = MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
		const CGFloat defaultWidth = MIN(280.0f, screenWidth);
		const CGFloat defaultOverDraw = screenWidth - defaultWidth;
		
		_widthInRevealController = NSMakeRange(defaultWidth, defaultOverDraw);
	}
	return self;
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor whiteColor];
	
	[self addChildViewController:self.viewController];
	self.viewController.view.bounds = self.view.bounds;
	
	[self.view addSubview:self.viewController.view];
	[self.viewController didMoveToParentViewController:self];
	
	[self adjustOverdrawInsets];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentationModeEntered:)
												 name:MCRevealControllerWillEnterPresentationModeNotification
											   object:self.revealController];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentationModeResigned:)
												 name:MCRevealControllerWillResignPresentationModeNotification
											   object:self.revealController];
}

- (void)viewDidLayoutSubviews
{
	if (self.presentationModeActive == NO)
	{
		[self adjustOverdrawInsets];
	}
}

- (void)presentationModeEntered:(NSNotification *)notification
{
	self.presentationModeActive = YES;
	[UIView animateWithDuration:self.revealController.animationDuration
						  delay:0.0f
						options:self.revealController.animationCurve
					 animations:^
	 {
		 [self adjustOverdrawInsets];
	 }
	completion:nil];
}

- (void)presentationModeResigned:(NSNotification *)notification
{
	self.presentationModeActive = NO;
	[UIView animateWithDuration:self.revealController.animationDuration
						  delay:0.0f
						options:self.revealController.animationCurve | UIViewAnimationOptionBeginFromCurrentState
					 animations:^
	 {
		 [self adjustOverdrawInsets];
	 }
					 completion:nil];
}

- (void)adjustOverdrawInsets
{
	[self.revealController setMinimumWidth:self.widthInRevealController.location
						 forViewController:self];
	if ([self isViewLoaded])
	{
		self.viewController.view.frame = self.view.bounds;
		if (self.controllerSideType == MCSideViewControllerTypeLeft)
		{
			if (self.presentationModeActive == NO)
			{
				self.viewController.view.$right = self.widthInRevealController.location;
			}
		}
		else if (self.controllerSideType == MCSideViewControllerTypeRight)
		{
			if (self.presentationModeActive == NO)
			{
				self.viewController.view.$left = self.view.bounds.size.width - self.widthInRevealController.location;
			}
		}
		[self.viewController.view layoutIfNeeded];
	}
}

- (void)setWidthInRevealController:(NSRange)widthInRevealController
{
	_widthInRevealController = widthInRevealController;
	[self adjustOverdrawInsets];
}

@end
