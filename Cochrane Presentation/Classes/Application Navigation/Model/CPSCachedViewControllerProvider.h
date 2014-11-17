//
//  CPSCachedViewControllerProvider.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/11.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSViewControllerProvider.h"

/**
 *  This concrete view controller provider simply caches a single view controller and returns that when requested
 */
@interface CPSCachedViewControllerProvider : NSObject <CPSViewControllerProvider>

+ (instancetype)providerWithCachedViewController:(UIViewController *)viewController;

@end
