//
//  MCImageArrayPagerDataSource.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/10.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MCImageLoader.h"

@interface MCImageArrayPagerDataSource : NSObject <UIPageViewControllerDataSource>

// Array of id<MCImageLoader> instances
@property (nonatomic, strong) NSArray * imageLoaders;

- (UIViewController *)viewControllerForImageAtIndex:(NSInteger)index;

@end
