//
//  CPSVideoListResourceWireframe.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/12.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSVideoListResourceWireframe.h"

@implementation CPSVideoListResourceWireframe

- (void)showVideoItemAdditionalResources:(id)resources
{
    // TODO: create interactor, presenter. Inject dependencies.
    UIViewController *contentController = [self instantiateNewViewControllerWithIdentifier:self.additionalResourceListViewControllerIdentifier];
    [self.presenter.userInterface embedContentViewController:contentController];
}

@end
