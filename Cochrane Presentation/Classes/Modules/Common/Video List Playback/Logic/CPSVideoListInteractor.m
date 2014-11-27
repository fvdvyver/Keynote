//
//  CPSVideoListInteractor.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/27.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSVideoListInteractor.h"

#import "CPSVideoListItem.h"

@implementation CPSVideoListInteractor

@synthesize wireframe = _wireframe;
@synthesize presenter = _presenter;

- (void)itemSelectedAtIndex:(NSUInteger)index
{
    CPSVideoListItem *item = self.videoItems[index];
    [self playVideoForItem:item];
}

- (void)playVideoForItem:(CPSVideoListItem *)item
{
    NSString *resourceName = [item.videoFilename stringByDeletingPathExtension];
    NSString *pathExtension = [item.videoFilename pathExtension];
    NSString *path = [[NSBundle mainBundle] pathForResource:resourceName ofType:pathExtension];
    
    if (path == nil)
    {
        NSLog(@"WARNING: video (%@) not found in the application's main bundle.", item.titleText);
    }
    else
    {
        [self.presenter playVideoAtPath:path];
    }
}

@end
