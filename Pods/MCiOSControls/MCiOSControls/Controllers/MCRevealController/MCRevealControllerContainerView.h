//
//  MCRevealControllerContainerView.h
//
//  Created by Rayman Rosevear on 2013/08/16. Heavily based
//	off the implementation of PKRevealController by
//	Philip Kluz (https://github.com/pkluz/PKRevealController)
//  Copyright (c) 2013 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface MCRevealControllerContainerView : UIView

#pragma mark - Properties
@property (nonatomic, weak, readwrite) UIViewController * viewController;
@property (nonatomic, assign) BOOL userInterActionEnabledForContainedView;

@property (nonatomic, weak, readwrite) id<UILayoutSupport> topLayoutGuide NS_AVAILABLE_IOS(7_0);
@property (nonatomic, weak, readwrite) id<UILayoutSupport> bottomLayoutGuide NS_AVAILABLE_IOS(7_0);

#pragma mark - Methods
- (id)initForController:(UIViewController *)controller;
- (id)initForController:(UIViewController *)controller shadow:(BOOL)hasShadow;

- (void)setTopLayoutGuide:(id<UILayoutSupport>)topLayoutGuide bottomLayoutGuide:(id<UILayoutSupport>)bottomLayoutGuide;

- (void)refreshShadowWithAnimationDuration:(NSTimeInterval)duration;

- (BOOL)hasShadow;

@end