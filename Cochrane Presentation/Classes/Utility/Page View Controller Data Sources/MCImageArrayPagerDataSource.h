//
//  MCImageArrayPagerDataSource.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/10.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCImageArrayPagerDataSource : NSObject <UIPageViewControllerDataSource>

@property (nonatomic, strong) NSArray * imageNames;

- (UIViewController *)viewControllerForImageAtIndex:(NSInteger)index;

@end
