//
//  MPMoviePlayerController+CPSAdditions.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/05.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "MPMoviePlayerController+CPSAdditions.h"

@implementation MPMoviePlayerController (CPSAdditions)

- (void)setControlStyleHidingInitially:(MPMovieControlStyle)controlStyle
{
    self.controlStyle = MPMovieControlStyleNone;

    typeof(self) __weak weakself = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
    {
        weakself.controlStyle = controlStyle;
    });
}

@end
