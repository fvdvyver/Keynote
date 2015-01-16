//
//  AppDelegate.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/06.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "AppDelegate.h"

#import "CPSAppContext.h"

@interface AppDelegate ()

@property (nonatomic, strong) CPSAppContext *applicationContext;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    CPSAppContext *applicationContext = [CPSAppContext new];
    [applicationContext configureApplicationWithWindow:self.window];

    self.applicationContext = applicationContext;
    
    // Delay the splash screen
    [NSThread sleepForTimeInterval:1];
    
    return YES;
}

@end
