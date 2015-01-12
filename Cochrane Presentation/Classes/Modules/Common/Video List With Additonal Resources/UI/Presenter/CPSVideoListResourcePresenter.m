//
//  CPSVideoListResourcePresenter.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/12.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSVideoListResourcePresenter.h"

@implementation CPSVideoListResourcePresenter

- (void)setItemResourceButtonVisible:(BOOL)visible
{
    [self.userInterface setAdditionalResourceButtonVisible:visible];
}

- (void)additionalResourceButtonTapped
{
    [self.interactor requestResourceForSelectedVideoItem];
}

@end
