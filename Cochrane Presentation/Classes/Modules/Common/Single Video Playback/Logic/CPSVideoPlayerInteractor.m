//
//  CPSVideoPlayerInteractor.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/21.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSVideoPlayerInteractor.h"

@implementation CPSVideoPlayerInteractor

@synthesize wireframe = _wireframe;
@synthesize presenter = _presenter;

- (void)requestVideoFilepath
{
    NSString *resourceName = [self.videoName stringByDeletingPathExtension];
    NSString *pathExtension = [self.videoName pathExtension];
    NSString *path = [[NSBundle mainBundle] pathForResource:resourceName ofType:pathExtension];
    
    [self.presenter playVideoAtPath:path];
}

@end
