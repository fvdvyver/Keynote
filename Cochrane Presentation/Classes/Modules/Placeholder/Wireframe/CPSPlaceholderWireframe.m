//
//  CPSPlaceholderWireframe.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/14.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSPlaceholderWireframe.h"

#import "CPSPlaceholderPresenter.h"
#import "CPSPlaceholderViewController.h"

@interface CPSPlaceholderWireframe ()

@property (nonatomic, readonly) NSString * storyboardName;

@property (nonatomic, strong) CPSPlaceholderPresenter *presenter;
@property (nonatomic, strong) CPSPlaceholderViewController *viewController;

- (UIStoryboard *)mainStoryboard;
- (CPSPlaceholderViewController *)newViewController;

@end

@implementation CPSPlaceholderWireframe

+ (instancetype)wireframeWithStoryboardName:(NSString *)storyboardName placeholderText:(NSString *)placeholderText
{
    CPSPlaceholderWireframe *wireframe = [self wireframeWithStoryboardName:storyboardName viewControllerID:@"PlaceholderViewController"];
    wireframe.placeholderText = placeholderText;
    
    return wireframe;
}

- (UIStoryboard *)mainStoryboard
{
    return [UIStoryboard storyboardWithName:self.storyboardName bundle:[NSBundle mainBundle]];
}

- (CPSPlaceholderViewController *)viewController
{
    if (_viewController == nil)
    {
        CPSPlaceholderPresenter *presenter = [CPSPlaceholderPresenter new];
        CPSPlaceholderViewController *viewController = [self newViewController];
        
        presenter.userInterface = viewController;
        viewController.eventHandler = presenter;
        
        self.presenter = presenter;
        self.viewController = viewController;
    }
    return _viewController;
}

- (CPSPlaceholderViewController *)newViewController
{
    return [self.mainStoryboard instantiateViewControllerWithIdentifier:@"PlaceholderViewController"];
}

- (UIViewController *)contentViewController
{
    UIViewController *viewController = self.viewController;
    [self.presenter setPlaceholderText:self.placeholderText];
    
    return viewController;
}

@end
