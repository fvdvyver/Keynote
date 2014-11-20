//
//  CPSBaseWireframe.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/19.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSBaseWireframe.h"

@interface CPSBaseWireframe ()

@property (nonatomic, strong, readwrite) NSString * storyboardName;
@property (nonatomic, strong, readwrite) NSString * viewControllerIdentifier;

- (UIStoryboard *)storyboard;
- (UIViewController *)instantiateNewViewController;

@end

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

- (UIViewController *)instantiateNewViewController
{
    return [self.storyboard instantiateViewControllerWithIdentifier:self.viewControllerIdentifier];
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
    UIViewController *viewController = [self instantiateNewViewController];
    [self configureNewContentViewController:viewController];
    
    return viewController;
}

- (void)advanceCurrentContentProvider
{
    [self.parentContentWireframe advanceCurrentContentProvider];
}

@end
