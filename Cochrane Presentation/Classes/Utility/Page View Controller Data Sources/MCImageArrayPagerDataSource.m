//
//  MCImageArrayPagerDataSource.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/10.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "MCImageArrayPagerDataSource.h"

#import "MCImageViewController.h"
#import "UIViewController+MCPagerIndexAdditions.h"

@interface MCImageArrayPagerDataSource ()

- (MCImageViewController *)newImageViewControllerForIndex:(NSInteger)index;
- (MCImageViewController *)newImageViewControllerForImageWithName:(NSString *)imageName;

@end

@implementation MCImageArrayPagerDataSource

- (UIViewController *)viewControllerForImageAtIndex:(NSInteger)index
{
    return [self newImageViewControllerForIndex:index];
}

- (MCImageViewController *)newImageViewControllerForIndex:(NSInteger)index
{
    MCImageViewController *viewController = nil;
    
    if (index >= 0 && index < self.imageNames.count)
    {
        NSString *imageName = self.imageNames[index];
        
        viewController = [self newImageViewControllerForImageWithName:imageName];
        viewController.mc_pagerIndex = index;
    }
    
    return viewController;
}

- (MCImageViewController *)newImageViewControllerForImageWithName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    MCImageViewController *viewController = [MCImageViewController new];
    viewController.image = image;
    
    return viewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    return [self newImageViewControllerForIndex:viewController.mc_pagerIndex - 1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    return [self newImageViewControllerForIndex:viewController.mc_pagerIndex + 1];
}

@end
