//
//  CPSViewControllerProviderUtils.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/20.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSViewControllerProvider.h"

UIViewController *CPSContentViewControllerFromProvider(id<CPSViewControllerProvider>provider)
{
    if ([provider respondsToSelector:@selector(prepareContentViewController)])
    {
        [provider prepareContentViewController];
    }
    return [provider contentViewController];
}
