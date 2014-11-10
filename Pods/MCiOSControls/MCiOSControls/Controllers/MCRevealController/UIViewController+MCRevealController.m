//
//  UIViewController+MCRevealController.m
//
//  Created by Rayman Rosevear on 2013/08/16. Heavily based
//	off the implementation of PKRevealController by
//	Philip Kluz (https://github.com/pkluz/PKRevealController)
//  Copyright (c) 2013 Mushroom Cloud. All rights reserved.
//

#import "UIViewController+MCRevealController.h"
#import "MCRevealController.h"
#import <objc/runtime.h>

@implementation UIViewController (MCRevealController)

static char revealControllerKey;

- (void)setRevealController:(MCRevealController *)revealController
{
    objc_setAssociatedObject(self, &revealControllerKey, revealController, OBJC_ASSOCIATION_ASSIGN);
}

- (MCRevealController *)revealController
{
	MCRevealController *revealController = (MCRevealController *)objc_getAssociatedObject(self, &revealControllerKey);
	if (revealController == nil && self.parentViewController != nil)
	{
		revealController = self.parentViewController.revealController;
	}
    return revealController;
}

@end
