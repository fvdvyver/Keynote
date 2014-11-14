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

- (void)showAlphaReleaseMessage;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    CPSAppContext *applicationContext = [CPSAppContext new];
    [applicationContext configureApplicationWithWindow:self.window];

    self.applicationContext = applicationContext;
    
    [self performSelector:@selector(showAlphaReleaseMessage) withObject:nil afterDelay:0.5];
    
    return YES;
}

- (void)showAlphaReleaseMessage
{
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alpha Release App", nil)
                                message:NSLocalizedString(@"Welcome to the Alpha release of the Cochrane presentation app.\n\n Please note that it does not currently have much functionality. Right now it is just a skeleton containing the navigational framework, the menu, and a few placeholder content views. However, you should be able to get a feel for the look and user experience the final product will have.\n\nYou can slide the view to the right to view the menu, and tap on the menu items to navigate to the different parts of the app (which are just placeholders at the moment).", nil)
                               delegate:nil
                      cancelButtonTitle:NSLocalizedString(@"OK", nil)
                      otherButtonTitles:nil] show];
}

@end
