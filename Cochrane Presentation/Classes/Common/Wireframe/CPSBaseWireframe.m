//
//  CPSBaseWireframe.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/19.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSBaseWireframe.h"

@implementation CPSBaseWireframe

+ (instancetype)wireframeWithStoryboardName:(NSString *)storyboardName viewControllerID:(NSString *)identifer
{
    CPSBaseWireframe *wireframe = [[self class] new];
    wireframe.storyboardName = storyboardName;
    wireframe.viewControllerIdentifier = identifer;
    
    return wireframe;
}

- (UIStoryboard *)storyboard
{
    return [UIStoryboard storyboardWithName:self.storyboardName bundle:nil];
}

- (UIViewController *)instantiateNewViewControllerWithIdentifier:(NSString *)identifier
{
    return [self.storyboard instantiateViewControllerWithIdentifier:identifier];
}

- (void)configureNewContentViewController:(UIViewController *)viewController
{
    [self.presenter setUserInterface:(id<CPSView>)viewController];
    if ([viewController respondsToSelector:@selector(setEventHandler:)])
    {
        [(id<CPSView>)viewController setEventHandler:self.presenter];
    }
}

- (UIViewController *)contentViewController
{
    UIViewController *viewController = [self instantiateNewViewControllerWithIdentifier:self.viewControllerIdentifier];
    [self configureNewContentViewController:viewController];
    
    return viewController;
}

- (void)advanceCurrentContentProvider
{
    [self.parentContentWireframe advanceCurrentContentProvider];
}

- (void)setContentControllerProviderWithIdentifer:(NSString *)identifier;
{
    [self.parentContentWireframe setContentControllerProviderWithIdentifer:identifier];
}

@end
