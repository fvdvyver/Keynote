//
//  UIViewController+MCRevealController.h
//
//  Created by Rayman Rosevear on 2013/08/16. Heavily based
//	off the implementation of PKRevealController by
//	Philip Kluz (https://github.com/pkluz/PKRevealController)
//  Copyright (c) 2013 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MCRevealController;

/*
 * This category extends every UIViewController with a revealController property.
 * It can be used in the same way as the navigationController property, thus
 * allowing simple access from all the relevant controllers, to enable quick and
 * easy message forwarding.
 */

@interface UIViewController (MCRevealController)

#pragma mark - Properties
@property (nonatomic, strong, readwrite) MCRevealController *revealController;

@end