//
//  CPSViewControllerProvider.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/10.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CPSViewControllerProvider <NSObject>

@required
- (UIViewController *)contentViewController;

@optional
- (void)prepareContentViewController;

@end

/**
 *  This will retrieve the view controller from the provider, calling -prepareContentViewController if the instance responds to it first
 */
UIViewController *CPSContentViewControllerFromProvider(id<CPSViewControllerProvider>provider);
