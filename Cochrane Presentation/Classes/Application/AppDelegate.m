//
//  AppDelegate.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/06.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "AppDelegate.h"

#import "CPSRootWireframe.h"
#import "CPSRootWireframe+CochranePresentationAdditions.h"

@interface AppDelegate ()

@property (nonatomic, strong) CPSRootWireframe *rootWireframe;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.rootWireframe = [CPSRootWireframe installRootWireframeInWindow:self.window];
    return YES;
}

@end
