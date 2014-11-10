//
//  MCSideViewController.h
//  ComSecure
//
//  Created by Rayman Rosevear on 2013/09/18.
//  Copyright (c) 2013 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *	This view controller is meant to be a container for a view controller that is
 *	to be used as either the left or right controller of the MCRevealController.
 *	It automatically adjusts its content to to fill its superview without being 
 *	blocked by the front view controller
 */

typedef NS_OPTIONS(NSUInteger, MCSideViewControllerType)
{
	MCSideViewControllerTypeLeft,
	MCSideViewControllerTypeRight
};

@interface MCSideViewController : UIViewController

@property (nonatomic, assign, readwrite) MCSideViewControllerType controllerSideType;
@property (nonatomic, assign, readwrite) NSRange widthInRevealController;

@property (nonatomic, strong, readonly) UIViewController *viewController;

- (id)initWithViewController:(UIViewController *)viewController;

@end
