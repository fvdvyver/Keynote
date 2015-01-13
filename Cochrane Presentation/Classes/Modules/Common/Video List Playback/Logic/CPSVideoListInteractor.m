//
//  CPSVideoListInteractor.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/27.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSVideoListInteractor.h"

#import "CPSAssetItem.h"

@implementation CPSVideoListInteractor

@synthesize wireframe = _wireframe;
@synthesize presenter = _presenter;

- (void)requestAllVideoItems
{
    [self.presenter setAllVideoItems:self.videoItems];
}

- (void)itemSelectedAtIndex:(NSUInteger)index
{
    CPSAssetItem *item = self.videoItems[index];
    [self itemSelected:item];
}

- (void)itemSelected:(CPSAssetItem *)item
{
    [self playVideoForItem:item];
}

- (void)playVideoForItem:(CPSAssetItem *)item
{
    NSString *resourceName = [item.primaryFilename stringByDeletingPathExtension];
    NSString *pathExtension = [item.primaryFilename pathExtension];
    NSString *path = [[NSBundle mainBundle] pathForResource:resourceName ofType:pathExtension];
    
    if (path == nil)
    {
        NSLog(@"WARNING: video (%@) not found in the application's main bundle.", item.title);
    }
    else
    {
        [self.presenter playVideoAtPath:path];
    }
}

@end
