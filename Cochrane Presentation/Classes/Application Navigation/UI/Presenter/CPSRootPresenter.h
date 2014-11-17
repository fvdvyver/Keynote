//
//  CPSRootPresenter.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/10.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CPSRootPresenter <NSObject>

- (void)setRootUserInterface:(UIViewController *)rootViewController;

- (void)setMenuViewController:(UIViewController *)menuViewController;
- (void)setContentViewController:(UIViewController *)contentViewController;

@end
