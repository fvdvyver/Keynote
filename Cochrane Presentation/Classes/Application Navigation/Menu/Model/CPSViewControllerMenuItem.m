//
//  CPSViewControllerMenuItem.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/10.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSViewControllerMenuItem.h"

@interface CPSViewControllerMenuItem ()

@property (nonatomic, readonly) UIStoryboard * storyboard;
@property (nonatomic, readonly) NSString * viewControllerIdentifier;

@end

@implementation CPSViewControllerMenuItem

@synthesize viewControllerIdentifier = _viewControllerIdentifier;

- (instancetype)initWithTitle:(NSString *)title
                         icon:(UIImage *)icon
     viewControllerIdentifier:(NSString *)controllerIdentifier
                 inStoryboard:(UIStoryboard *)storyboard
{
    if (self = [super initWithTitle:title icon:icon])
    {
        _storyboard = storyboard;
        _viewControllerIdentifier = controllerIdentifier;
    }
    return self;
}

- (UIViewController *)contentViewController
{
    return [self.storyboard instantiateViewControllerWithIdentifier:self.viewControllerIdentifier];
}

- (NSString *)viewControllerIdentifier
{
    return _viewControllerIdentifier;
}

@end
