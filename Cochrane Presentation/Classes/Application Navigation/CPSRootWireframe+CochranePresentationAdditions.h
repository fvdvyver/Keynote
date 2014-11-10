//
//  CPSRootWireframe+CochranePresentationAdditions.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/10.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSRootWireframe.h"

/**
 *  This category adds a method which configures an application window to use a CPSRootWireframe instance to manage the navigation of the application.
 */
@interface CPSRootWireframe (CochranePresentationAdditions)

/**
 *  Sets up the window to use a CPSRootWireframe instance to manage application navigation.
 *  Implicit assumption: the root view controller of the window is already a reveal controller. This can be set up in a storyboard, nib, or programmatically.
 *
 *  @param window   the reveal controller is obtained from this window to set up the root wireframe instance to use.
 *  @return the wireframe instance that will manage the navigation of the app
 */
+ (CPSRootWireframe *)installRootWireframeInWindow:(UIWindow *)window;

@end
