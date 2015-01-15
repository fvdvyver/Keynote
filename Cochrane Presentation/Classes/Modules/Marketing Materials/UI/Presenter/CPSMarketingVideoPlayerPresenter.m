//
//  CPSMarketingVideoPlayerPresenter.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/15.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSMarketingVideoPlayerPresenter.h"

@implementation CPSMarketingVideoPlayerPresenter

- (void)viewDoubleTapped
{
    [self.wireframe showRootViewController];
}

- (void)videoPlaybackFinished
{
    [self.wireframe showRootViewController];
}

@end
